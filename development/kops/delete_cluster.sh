#!/usr/bin/env bash
# Copyright 2020 Amazon.com Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eo pipefail

export KOPS_STATE_STORE=${1:-${KOPS_STATE_STORE}}
if [ -z "${KOPS_STATE_STORE}" ]
then
  echo "Usage: ${0} s3://bucketname"
  echo "  or set and export KOPS_STATE_STORE"
  exit 1
fi
if [[ "${KOPS_STATE_STORE}" != s3://* ]]
then
  export KOPS_STATE_STORE="s3://${KOPS_STATE_STORE}"
fi

echo "Deleting cluster $KOPS_STATE_STORE ${KOPS_CLUSTER_NAME}"
set -x
kops delete cluster --state "${KOPS_STATE_STORE}" --name "${KOPS_CLUSTER_NAME}" --yes
set +x
