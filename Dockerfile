# TODO: uncomment
# FROM ghcr.io/foliant-docs/foliant/foliant:slim
FROM docker.io/foliant/foliant:slim

RUN pip3 install foliantcontrib.init
