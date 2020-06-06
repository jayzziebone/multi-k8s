docker build -t jayzziebone/multi-client:latest -t jayzziebone/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jayzziebone/multi-server:latest -t jayzziebone/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jayzziebone/multi-worker:latest -t jayzziebone/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jayzziebone/multi-client:latest
docker push jayzziebone/multi-server:latest
docker push jayzziebone/multi-worker:latest

docker push jayzziebone/multi-client:$SHA
docker push jayzziebone/multi-server:$SHA
docker push jayzziebone/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jayzziebone/multi-server:$SHA
kubectl set image deployments/client-deployment client=jayzziebone/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jayzziebone/multi-worker:$SHA