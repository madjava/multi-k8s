docker build -t madjava/multi-client:latest -t madjava/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t madjava/multi-server:latest -t madjava/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t madjava/multi-worker:latest -t madjava/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push madjava/multi-client:latest
docker push madjava/multi-server:latest
docker push madjava/multi-worker:latest

docker push madjava/multi-client:$SHA
docker push madjava/multi-server:$SHA
docker push madjava/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=madjava/multi-server:$SHA
kubectl set image deployments/client-deployment client=madjava/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=madjava/multi-worker:$SHA