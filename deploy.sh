docker build -t carlosalonsogtz/multi-client:latest -t carlosalonsogtz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t carlosalonsogtz/multi-server:latest -t carlosalonsogtz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t carlosalonsogtz/multi-worker:latest -t carlosalonsogtz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push carlosalonsogtz/multi-client:latest
docker push carlosalonsogtz/multi-server:latest
docker push carlosalonsogtz/multi-worker:latest

docker push carlosalonsogtz/multi-client:$SHA
docker push carlosalonsogtz/multi-server:$SHA
docker push carlosalonsogtz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=stephengrider/multiserver
kubectl set image deployments/server-deployment server=carlosalonsogtz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=carlosalonsogtz/multi-worker:$SHA
