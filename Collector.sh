#!/bin/bash

# The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty
# of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness 
# for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event 
# shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever 
# (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) 
# arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.

read -p "Enter your AKS Cluster Name: " cluster
read -p "Enter resource group from your AKS Cluster: " rg

CLUSTER_NAME=$cluster
RESOURCE_GROUP_NAME=$rg

showError(){
	echo -e "\nERROR: $1\n"
	exit 1
}

echo "|#0|" > output.log
echo "" >> output.log
kubectl get namespaces -o json &>> output.log
echo "" >> output.log
echo "|#0|" >> output.log

echo "|#1|" >> output.log
echo "" >> output.log
kubectl get pods --all-namespaces -o json &>> output.log
echo "" >> output.log
echo "|#1|" >> output.log

echo "|#2|" >> output.log
echo "" >> output.log
kubectl get deploy --all-namespaces -o json &>> output.log
echo "" >> output.log
echo "|#2|" >> output.log

echo "|#3|" >> output.log
echo "" >> output.log
kubectl get resourcequotas --all-namespaces -o json &>> output.log
echo "" >> output.log
echo "|#3|" >> output.log

echo "|#4|" >> output.log
echo "" >> output.log
kubectl get pdb --all-namespaces -o json &>> output.log
echo "" >> output.log
echo "|#4|" >> output.log

echo "|#5|" >> output.log
echo "" >> output.log
kubectl get rs --all-namespaces -o json &>> output.log
echo "" >> output.log
echo "|#5|" >> output.log

echo "|#6|" >> output.log
echo "" >> output.log
kubectl get nodes -o json &>> output.log
echo "" >> output.log
echo "|#6|" >> output.log

echo "|#7|" >> output.log
echo "" >> output.log
kubectl version -o json &>> output.log
echo "" >> output.log
echo "|#7|" >> output.log

echo "|#8|" >> output.log
echo "" >> output.log
kubectl get networkpolicy -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#8|" >> output.log

echo "|#9|" >> output.log
echo "" >> output.log
kubectl get hpa -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#9|" >> output.log

echo "|#10|" >> output.log
echo "" >> output.log
kubectl get ingress -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#10|" >> output.log

echo "|#11|" >> output.log
echo "" >> output.log
kubectl get pv -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#11|" >> output.log

echo "|#12|" >> output.log
echo "" >> output.log
kubectl get pvc -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#12|" >> output.log

echo "|#13|" >> output.log
echo "" >> output.log
kubectl get secret -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#13|" >> output.log

echo "|#14|" >> output.log
echo "" >> output.log
kubectl get storageclass -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#14|" >> output.log


if [ -n "$RESOURCE_GROUP_NAME" ] && [ -n "$CLUSTER_NAME" ] 
then
	echo "|#15|" >> output.log
	echo "" >> output.log
	az aks show -g $RESOURCE_GROUP_NAME --name $CLUSTER_NAME  &>> output.log
	echo "" >> output.log
	echo "|#15|" >> output.log
fi

echo "|#16|" >> output.log
echo "" >> output.log
kubectl get ds -o json --all-namespaces &>> output.log
echo "" >> output.log
echo "|#16|" >> output.log

sed -i '/WARNING: The behavior of this command has been altered by the following extension: aks-preview/c "",/g' output.log
sed -i '/\"token\":/c\   \"token\": \"\"' output.log
sed -i '/\"ca.crt\":/c\   \"ca.crt\": \"\"' output.log
sed -i '/\"keyData\":/c\   \"keyData\": \"\"' output.log
sed -i '/\"client.crt\":/c\   \"client.crt\": \"\"' output.log
sed -i '/\"client.key\":/c\   \"client.key\": \"\"' output.log

exit 0
