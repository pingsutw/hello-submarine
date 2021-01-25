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

## Build from local
```bash
docker build --tag mini-submarine:latest -f Dockerfile .

# Build for dockerhub
docker build --tag pingsutw/mini-submarine:latest -f Dockerfile .
```

## Run TensorFlow mini-submarine locally
```bash
docker run -it mini-submarine:latest bash
# or
docker run -it pingsutw/mini-submarine:latest bash
```
