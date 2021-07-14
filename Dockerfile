# Copyright (c) 2021 NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
