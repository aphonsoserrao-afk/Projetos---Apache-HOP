#!/usr/bin/env python
# coding: utf-8

# In[9]:


import io
import re
import csv
from datetime import timedelta
from minio import Minio
from minio.error import S3Error

# === Configurações de acesso ===
minio_url = "minio-prod.apps.ocp.semas.local"
access_key = "sinaflor-bi"
secret_key = "EGq9umN6GdU1"
bucket_name = "sinaflor"
object_prefix = "payloads/"

client = Minio(
    minio_url,
    access_key=access_key,
    secret_key=secret_key,
    secure=False  # troque para True se o endpoint for HTTPS
)

# === Geração de links e exportação para CSV ===
saida_csv = "payload_links.csv"
linhas = []

objects = client.list_objects(bucket_name, prefix=object_prefix)

for obj in objects:
    object_name = obj.object_name  # ex.: payloads/1769a.zip

    # Extrai apenas os números do nome do arquivo (após a barra)
    # cobre casos como 2693av.zip → 2693
    m = re.search(r"/(\d+)", object_name)
    numero = m.group(1) if m else ""

    # Link pré-assinado (download) - ajuste a validade conforme necessário
    url = client.presigned_get_object(
        bucket_name,
        object_name,
        expires=timedelta(days=7)  # link válido por 7 dias (limite do SDK do MinIO)
    )

    # Fórmula útil se alguém abrir o CSV no Excel (mostra o número como texto do link)
    excel_hyperlink = f'=HYPERLINK("{url}","{numero}")'

    linhas.append({
        "numero": numero,
        "arquivo": object_name,
        "url": url,
        "excel_hyperlink": excel_hyperlink
    })

# Escreve o CSV
with open(saida_csv, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["numero", "arquivo", "url", "excel_hyperlink"])
    writer.writeheader()
    writer.writerows(linhas)

print(f"Arquivo gerado: {saida_csv} ({len(linhas)} linhas)")


# In[ ]:





# In[ ]:




