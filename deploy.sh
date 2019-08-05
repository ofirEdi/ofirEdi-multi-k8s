docker build -t ofiredi585/multi-client:latest -t ofiredi585/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ofiredi585/multi-server:latest -t ofiredi585/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ofiredi585/multi-worker:latest -t ofiredi585/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ofiredi585/multi-client:latest
docker push ofiredi585/multi-server:latest
docker push ofiredi585/multi-worker:latest

docker push ofiredi585/multi-client:$SHA
docker push ofiredi585/multi-server:$SHA
docker push ofiredi585/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=ofiredi585/multi-server:$SHA
kubectl set image deployment/client-deployment client=ofiredi585/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=ofiredi585/multi-worker:$SHA