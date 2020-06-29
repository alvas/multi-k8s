docker build -t alvasli/multi-client:latest -t alvasli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvasli/multi-server:latest -t alvasli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alvasli/multi-worker:latest -t alvasli/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alvasli/multi-client:latest
docker push alvasli/multi-server:latest
docker push alvasli/multi-worker:latest

docker push alvasli/multi-client:$SHA
docker push alvasli/multi-server:$SHA
docker push alvasli/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=alvasli/multi-client:$SHA
kubectl set image deployments/server-deployment server=alvasli/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alvasli/multi-worker:$SHA
