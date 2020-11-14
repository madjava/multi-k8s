docker build -t madjava/multi-client -f ./client/Dockerfile ./client
docker build -t madjava/multi-server -f ./server/Dockerfile ./server
docker build -t madjava/multi-worker -f ./worker/Dockerfile ./worker
docker push madjava/multi-client
docker push madjava/multi-server
docker push madjava/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=madjava/multi-server