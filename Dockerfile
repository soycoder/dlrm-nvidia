ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:21.04-py3
FROM ${FROM_IMAGE_NAME}

WORKDIR /workspace/dlrm

RUN git clone https://github.com/NVIDIA/DeepLearningExamples
RUN cp -a DeepLearningExamples/PyTorch/Recommendation/DLRM/* /workspace/dlrm/
RUN rm -rf DeepLearningExamples/

ADD requirements.txt .
RUN pip install -r requirements.txt

RUN chmod +x bind.sh
RUN pip install --no-cache-dir -e .
