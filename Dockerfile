FROM oracle/graalvm-ce:19.2.1

LABEL maintainer="Juan Carlos Gonzalez <malkomich@gmail.com>"

ARG MAVEN_VERSION=3.6.2
ARG SHA=d941423d115cd021514bfd06c453658b1b3e39e6240969caf4315ab7119a77299713f14b620fb2571a264f8dff2473d8af3cb47b05acf0036fc2553199a5c1ee
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref
RUN curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN echo "${SHA} /tmp/apache-maven.tar.gz" | sha512sum -c -
RUN tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1
RUN rm -f /tmp/apache-maven.tar.gz
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/root/.m2"
ENV GRAALVM_HOME "$JAVA_HOME"
ENV PATH "$PATH:$GRAALVM_HOME/bin"

RUN gu install native-image

CMD ["mvn"]
