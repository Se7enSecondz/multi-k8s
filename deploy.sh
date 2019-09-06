docker build -t chrishao/multi-client:latest -t chrishao/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t chrishao/multi-server:latest -t chrishao/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t chrishao/nulti-worker:latest -t chrishao/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chrishao/multi-client:latest
docker push chrishao/multi-client:$SHA

docker push chrishao/multi-server:latest
docker push chrishao/multi-server:$SHA

docker push chrishao/multi-worker:latest
docker push chrishao/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=chrishao/multi-server:$SHA

kubectl set image deployments/client-deployment client=chrishao/multi-client:$SHA

kubectl set image deployments/worker-deployment worker=chrishao/multi-worker:$SHA