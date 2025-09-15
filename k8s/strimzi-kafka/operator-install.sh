#!/bin/bash
namespace="default"
kubectl -n "$namespace" apply -f "https://strimzi.io/install/latest?namespace=${namespace}"