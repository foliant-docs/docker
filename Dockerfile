# TODO: uncomment
FROM ghcr.io/foliant-docs/foliant/foliant:1.0.14-slim
# FROM docker.io/foliant/foliant:1.0.14-slim

RUN pip3 install foliantcontrib.init
