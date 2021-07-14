ARG CUDF_VERSION=0.18
ARG RAPIDS_VERSION=0.4.0
ARG SPARK_VERSION=3.0.1
ARG DGX_VERSION=DGX-A100
ARG NUMBER_OF_GPUS
ARG FROM_IMAGE_NAME=nvcr.io/nvidia/nvtabular:0.3
FROM ${FROM_IMAGE_NAME} AS base
ARG CUDF_VERSION
ARG RAPIDS_VERSION
ARG SPARK_VERSION
ARG DGX_VERSION
ARG NUMBER_OF_GPUS

RUN apt update &&                  \
    apt install -y openjdk-8-jdk && \
    apt install -y curl

RUN curl https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz -o /opt/spark.tgz && \
    tar zxf /opt/spark.tgz -C /opt/ && \
    mv /opt/spark-$SPARK_VERSION-bin-hadoop2.7 /opt/spark && \
    rm /opt/spark.tgz && \
    curl https://repo1.maven.org/maven2/ai/rapids/cudf/0.18.1/cudf-0.18.1-cuda11.jar -o /opt/cudf.jar && \
    curl https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark_2.12/0.4.0/rapids-4-spark_2.12-0.4.0.jar  -o /opt/rapids-4-spark.jar && \
    apt install -y git

WORKDIR /workspace/dlrm

COPY . .

RUN mv /opt/cudf.jar  /opt/spark/jars &&                                                   \
    mv /opt/rapids-4-spark.jar /opt/spark/jars/ &&                                          \
    mv /workspace/dlrm/preproc/gpu/get_gpu_resources.sh /opt/spark/conf/ &&                  \
    mv /workspace/dlrm/preproc/gpu/spark-defaults.conf /opt/spark/conf/spark-defaults.conf && \
    rm -rf /workspace/dlrm/preproc/gpu

RUN chmod +x /workspace/dlrm/preproc/run_spark_gpu_$DGX_VERSION.sh
RUN chmod +x /opt/spark/conf/get_gpu_resources.sh
RUN chmod +x /workspace/dlrm/preproc/run_NVTabular.sh

ENV SPARK_HOME /opt/spark
ENV PYTHONPATH $SPARK_HOME/python
ENV PYSPARK_PYTHON /conda/envs/rapids/bin/python
ENV PYSPARK_DRIVER_PYTHON /conda/envs/rapids/bin/python
ENV DGX_VERSION $DGX_VERSION
ENV SPARK_VERSION $SPARK_VERSION


SHELL ["/bin/bash", "-c"]

RUN source activate rapids &&                                  \
    pip install --upgrade pip &&                                \
    pip install --no-cache-dir -r requirements_preprocessing.txt


FROM base AS image-machine-dgx-a100
ENV NUMBER_OF_GPUS 8

FROM image-machine-dgx-a100 AS final
RUN echo "spark.worker.resource.gpu.amount    ${NUMBER_OF_GPUS}" >> /opt/spark/conf/spark-defaults.conf
