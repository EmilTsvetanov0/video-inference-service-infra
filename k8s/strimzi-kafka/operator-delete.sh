#!/bin/bash
namespace="default"
kubectl -n "$namespace" delete -f "https://strimzi.io/install/latest?namespace=${namespace}"