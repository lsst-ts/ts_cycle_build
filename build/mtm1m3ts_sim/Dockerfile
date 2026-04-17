ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer Petr Kubánek <petr.kubanek@noirlab.edu>

WORKDIR /home/saluser/

RUN source /home/saluser/.crio_setup.sh \
    && salgeneratorKafka generate cpp MTM1M3TS
    
ARG m1m3ts
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3thermal

RUN source /home/saluser/.crio_setup.sh \
    && cd ts_m1m3thermal \
    && /home/saluser/.checkout_repo.sh ${m1m3ts} \
    && make -j$(nproc) simulator

USER root
COPY --chown=saluser:saluser --chmod=a+x mtm1m3ts_sim/startup.sh /home/saluser/.startup.sh
COPY --chown=saluser:saluser --chmod=a+x mtm1m3ts_sim/create_topics_mtm1m3ts.py /home/saluser/.create_topics_mtm1m3ts.py
USER saluser

ENV RUN_ARG=""
