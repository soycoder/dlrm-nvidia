ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:21.04-py3
FROM ${FROM_IMAGE_NAME}

ADD requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /workspace/dlrm

RUN git clone https://github.com/NVIDIA/DeepLearningExamples
RUN cp -a DeepLearningExamples/PyTorch/Recommendation/DLRM/* /workspace/dlrm/
RUN rm -rf DeepLearningExamples/

RUN chmod +x bind.sh
RUN pip install --no-cache-dir -e .
