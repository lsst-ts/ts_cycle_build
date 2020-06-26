ARG deploy_tag

FROM lsstts/develop-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG ataos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_ataos.git

WORKDIR /home/saluser/repos/ts_ataos

RUN source /home/saluser/.setup.sh && \
    /home/saluser/.checkout_repo.sh ${ataos} && \
    eups declare -r . -t current && \
    setup ts_ataos -t current && \
    scons || pytest --lf

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup_dev.sh
