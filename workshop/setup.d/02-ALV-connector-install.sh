#!/bin/bash
cat <<EOF >> connector.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: app-live-view-connector
      labels:
        app: app-live-view-connector
    spec:
      selector:
        matchLabels:
          name: app-live-view-connector
      template:
        metadata:
          labels:
            name: app-live-view-connector
        spec:
          serviceAccountName: app-live-view-connector-service-account
          imagePullSecrets:
            - name: alv-secret-values
          containers:
            - name: app-live-view-connector
              image: registry.pivotal.io/app-live-view/application-live-view-connector@sha256:0ac86e77440402089651d21d10c51d90001d833ef7e56f35560e31100e0d4fd1 
              imagePullPolicy: Always
              livenessProbe:
                httpGet:
                  path: /health
                  port: 8787
                initialDelaySeconds: 15
                periodSeconds:  5
                timeoutSeconds:  3
              env:
                - name: app.live.view.client.host
                  value: app-live-view-7000
                - name: app.live.view.client.port
                  value: "7000"
                - name: NODE_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: spec.nodeName
                - name: NAMESPACE_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
                - name: app.live.view.connector.mode
                  value: namespace-scoped
EOF

kubectl get secret alv-secret-values --namespace=app-live-view --export -o yaml | kubectl apply --namespace=$SESSION_NAMESPACE -f -

kubectl apply -f connector.yaml -n $SESSION_NAMESPACE