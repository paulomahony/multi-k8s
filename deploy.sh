docker build -t paulom77/multi-client:latest -t paulom77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paulom77/multi-server:latest -t paulom77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulom77/multi-worker:latest -t paulom77/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paulom77/multi-client:latest
docker push paulom77/multi-server:latest
docker push paulom77/multi-worker:latest

docker push paulom77/multi-client:$SHA
docker push paulom77/multi-server:$SHA
docker push paulom77/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paulom77/multi-server:$SHA
kubectl set image deployments/client-deployment client=paulom77/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paulom77/multi-worker:$SHA
