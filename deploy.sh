docker build -t ghostyat/multi-client:latest -t ghostyat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ghostyat/multi-server:latest -t ghostyat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ghostyat/multi-worker:latest -t ghostyat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ghostyat/multi-client:latest
docker push ghostyat/multi-server:latest
docker push ghostyat/multi-worker:latest

docker push ghostyat/multi-client:$SHA
docker push ghostyat/multi-server:$SHA
docker push ghostyat/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ghostyat/multi-server:$SHA
kubectl set image deployments/client-deployment client=ghostyat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ghostyat/multi-worker:$SHA