#!/bin/bash

set -eu

assert_non_error_response() {
  curl --silent --fail -v --output /dev/null "${HOST}${1}"
}

assert_non_error_response_and_contains() {
  if curl --silent --fail -v "${HOST}${1}" --stderr - | grep -q "${2}"; then
    true
  else
    echo "${HOST}${1}" did not contain \""${2}"\"
    exit 1
  fi
}

assert_non_error_response_and_contains / EngineerBetter
assert_non_error_response /about-us.html "About us"
assert_non_error_response_and_contains /about-us/ "About us"
assert_non_error_response /how-we-work.html
assert_non_error_response_and_contains /how-we-work/ "How we work"

# Routes that point to blog app
assert_non_error_response /bad
assert_non_error_response /update/2017/10/05/post-devops.html
assert_non_error_response /why-eb.html
assert_non_error_response /2017/05/03/introducing-concourse-up.html
assert_non_error_response /2016/09/20/engineerbetter-hazelcast-cloud-foundry.html
assert_non_error_response /update/2015/05/15/cf-summit-2015-themes.html
assert_non_error_response /brain-aligned-delivery
assert_non_error_response /7-stages-of-bosh

echo Tests passed