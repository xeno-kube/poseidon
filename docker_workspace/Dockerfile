FROM alpine
MAINTAINER riderstrider001@gmail.com

# add docker-entrypoint.sh
ADD docker-entrypoint.sh /docker-entrypoint.sh

# add stress_cluster script
ADD stress_cluster /usr/local/bin/stress_cluster

# add start_stress script
ADD start_stress /usr/local/bin/start_stress

# add deploy_poseidon yaml
ADD deploy_poseidon.yaml /deploy_poseidon.yaml

RUN echo "updating container" \
 && apk -q update \
#
 && echo "installing and updating ca-certificates" \
 && apk -q add ca-certificates \
 && update-ca-certificates \
#
 && echo "installing wget" \
 && apk -q add wget \
#
 && echo "installing g++" \
 && apk -q add g++ \
#
 && echo "installing make" \
 && apk -q add make \
#
 && echo "installing kubectl" \
 && mkdir /root/.kube \
 && wget -q -nv -O /stable.txt https://storage.googleapis.com/kubernetes-release/release/stable.txt \
 && latest=$(cat /stable.txt) \
 && wget -q -nv -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$latest/bin/linux/amd64/kubectl \
 && rm -f /stable.txt \
 && chmod +x /usr/local/bin/kubectl \
#
 && echo "Downloading, unpacking, and installing stress" \
 && wget -q -nv -O /stress-1.0.4.tar.gz https://people.seas.harvard.edu/~apw/stress/stress-1.0.4.tar.gz \
 && tar -xvzf /stress-1.0.4.tar.gz \
 && cd stress-1.0.4 \
 && ./configure && make && make install \
 && cd / \
#
 && echo "initialising poseidon_activity.log" \
 && echo "[$(date)] --- initialising Poseidon ---" > /poseidon_activity.log \
#
 && echo "making stress_cluster script executable" \
 && chmod +x /usr/local/bin/stress_cluster \
#
 && echo "making start_stress script executable" \
 && chmod +x /usr/local/bin/start_stress \
#
 && echo "creating cron job for cluster stress" \
 && echo "0 * * * * /usr/local/bin/stress_cluster" > /etc/crontabs/root \
#
 && echo "creating cron job for log truncation" \
 && echo "5 1 * * 0 echo '' > /poseidon_activity.log" >> /etc/crontabs/root \
#
 && echo "making docker-entrypoint.sh executable" \
 && chmod +x /docker-entrypoint.sh \
#
 && echo "creating ENTRYPOINT as docker-entrypoint.sh"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["Poseidon has initialised. Starting Poseidon..."]
