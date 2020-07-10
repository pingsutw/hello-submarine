<!---
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
## Run test image
```bash
docker build --tag test -f Dockerfile.test .
docker run --rm --pid=host --privileged \
    -v /home/dslab/git/hello-submarine/docker:/workspace \
    -w /workspace \
    -e "CI_BUILD_HOME=/workspace" \
    -e "CI_BUILD_USER=$(id -u -n)" \
    -e "CI_BUILD_UID=$(id -u)" \
    -e "CI_BUILD_GROUP=$(id -g -n)" \
    -e "CI_BUILD_GID=$(id -g)" \
    -it test \
    bash --login test.sh bash
```

## Build from local
```bash
docker build --tag tf-deepfm -f Dockerfile.deepfm .

# Build for dockerhub
docker build --tag pingsutw/tf-deepfm -f Dockerfile.deepfm .
```

## Run TensorFlow DeepFM locally
```bash
docker run -it tf-deepfm bash
# or
docker run -it pingsutw/tf-deepfm bash
```