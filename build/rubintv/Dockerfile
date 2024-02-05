ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG rubintv

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts \
    rubintv=${rubintv}

RUN pip install safir

RUN git clone https://github.com/lsst-ts/rubintv
RUN cd rubintv && \
    git checkout v${rubintv} && \
    npm run build

LABEL rubintv=${rubintv}

COPY startup.sh /home/saluser/.startup.sh 
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser