FROM public.ecr.aws/docker/library/golang:1.22.2-bookworm as builder

# 创建工作目录
RUN mkdir /data

# 设置工作目录
WORKDIR /data

# 复制代码
COPY . /data



# build
RUN cd /data && go build -o app

# slim
FROM public.ecr.aws/debian/debian:12.5-slim

# 项目配置环境变量
ENV GOENV prod_cn


# 创建工作目录
RUN mkdir /data

# 设置工作目录
WORKDIR /data

# 复制执行文件
COPY --from=builder /data/app /data

# 使用 apt 安装 curl 和证书
RUN apt update && \
    apt install -y --no-install-recommends curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

#
EXPOSE 3000
#
ENTRYPOINT ["./app"]
