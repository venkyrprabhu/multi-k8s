docker build -t venkyprabhu/multi-client:latest -t venkyprabhu/multi-client:$SHA ./client/Dockerfile ./client
docker build -t venkyprabhu/multi-server:latest -t venkyprabhu/multi-server:$SHA ./server/Dockerfile ./server
docker build -t venkyprabhu/multi-worker:latest -t venkyprabhu/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push venkyprabhu/multi-client:latest
docker push venkyprabhu/multi-server:latest
docker push venkyprabhu/multi-worker:latest
docker push venkyprabhu/multi-client:$SHA
docker push venkyprabhu/multi-server:$SHA
docker push venkyprabhu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=venkyprabhu/multi-client:$SHA
kubectl set image deployments/server-deployment server=venkyprabhu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=venkyprabhu/multi-worker:$SHA
