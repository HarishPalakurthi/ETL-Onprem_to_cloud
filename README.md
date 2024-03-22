# Migration ETL data pipeline showing End - to - End implementation using Azure Data Factory, Azure Databricks, Azure Synapse Analytics, Azure Data Lake Gen2 to provide transformed data for reporting
## Project Overview:
Migration of On premise SQL Server data to cloud environment (Azure) using data factory as ingestion tool, azure data lake as storage solution, databricks as compute/transformation tool, synapse analytics as data loading for reporting via PowerBI.
## Architecture - Migration Pipeline:
![Screenshot 2024-03-22 122837](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/2131b971-d743-455a-9f2a-2982f4007190)
### Technologies and Functions:
* Azure data factory: Pipeline authoring for ingestion and transformation
* Azure Databricks: Data processing and transformation
* Azure Datalake Gen2: Storage of raw and transformed data in bronze, silver and gold layers
* Azure Synapse Analytics: Creation of data in consumable form for reporting
* Azure Keyvalut: For storing secrets and connection strings
* Azure Active Directory: Maintaining access for groups and members
* Power BI: Visualization of data (reporting)

## Steps to Perform the Migration

### 1. Creating Username and Password for On-premise SQL Server

- Obtain necessary credentials for accessing the on-premise SQL Server database.
- Create a username and password with appropriate permissions to access the database.
![Screenshot 2024-03-22 113146](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/184e9f53-1d4b-41eb-ab9b-14fbcbeed683)

### 3. Creating Required Services on Azure

- Set up an Azure subscription if not already done.
- Create the following Azure services:
  - Azure Data Factory
  - Azure Data Lake Storage Gen2
  - Azure Databricks
  - Azure Synapse Analytics
  - Azure KeyVault
  ![Screenshot 2024-03-22 112147](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/a0ec3fef-92db-4925-93e8-2db21fc4d1e1)

### 2. Storing Credentials in Azure Key Vault

- Create an Azure Key Vault to securely store the username and password for the on-premise SQL Server.
- Add the credentials as secrets in the Azure Key Vault.

### 4. Creating Containers in Azure Data Lake Gen2

- Create containers named **"bronze," "silver," and "gold"** in Azure Data Lake Storage Gen2 to organize the data lake storage.
![Screenshot 2024-03-22 111714](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/32a196b4-02a6-4925-bbe8-6856dc5888cd)

### 5. Data Ingestion Using Azure Data Factory

- Configure linked services in Azure Data Factory for on-premise SQL Server and Azure Data Lake Storage Gen2.
  ![Screenshot 2024-03-22 112724](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/d3803990-9d50-4d7c-85e7-3b8fb0baa89e)
- Author pipelines in Azure Data Factory to ingest data from on-premise SQL Server to the "bronze" container in Azure Data Lake Storage Gen2.
![Screenshot 2024-03-22 112426](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/4870f07f-dbfe-4022-8d79-f3b92455667c)
![Screenshot 2024-03-22 112447](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/2237b89e-86ff-464f-b010-2e149eec9af7)
![Screenshot 2024-03-22 112503](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/fa85033a-c49d-4b80-ab89-bc3dcee8c93e)
![Screenshot 2024-03-22 112527](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/d559d530-6e37-43cd-aeca-4042607e3786)
![Screenshot 2024-03-22 112541](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/71e85c3f-546a-4810-bc21-197ea70e5955)
![Screenshot 2024-03-22 112640](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/ac97a804-1dae-4024-bfe3-12bdb0169a2a)
![Screenshot 2024-03-22 112658](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/2d217949-04f8-41f2-8e59-b226330f6d30)
- After succesfully running the above pipline we can see the data in the gold container
![Screenshot 2024-03-22 112830](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/b9778521-5929-4c1e-ae9b-976e552f6778)
![Screenshot 2024-03-22 111943](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/a21978c8-64f6-477e-9879-3935f46f146c)

### 6. Data Transformation Using Azure Databricks (step 5 and step 6 are to be simultaneously)

- Create a spark cluster in the databricks as per the requirement
  ![Screenshot 2024-03-22 110907](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/e4466707-0db3-482d-acc2-93be7fd8c6fb)
- Create Python notebook files in Azure Databricks for mounting of storage and for data transformation tasks.
- Attach the .ipynb files to the Azure Data Factory pipeline.
- Use linked services to connect Azure Data Factory to Azure Databricks for execution of transformation tasks.
- Transform the ingested data and store it in the "silver" and "gold" containers in Azure Data Lake Storage Gen2.
**(Refer to the scripts folder for mounting and transformation code)**
![Screenshot 2024-03-22 110750](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/72ffde6b-95b8-4368-9970-02fe21d725d0)

### 7. Creating Views in Azure Synapse Analytics

- Establish linked services in Azure Synapse Analytics for Azure Data Lake Storage Gen2 and Power BI.
- Utilize Azure Synapse Analytics to create views based on the transformed data stored in "gold" container. **(refer stored procedure in scripts folder)**
- Design the views to provide the necessary data structure for reporting purposes.
![Screenshot 2024-03-22 111412](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/977e5d86-d434-4143-94dc-4b202d5a6200)
![Screenshot 2024-03-22 111444](https://github.com/HarishPalakurthi/ETL-Onprem_to_cloud/assets/120787926/c4150e41-abfb-4673-a94b-94d115beb780)

### 8. Reporting with Power BI

- Connect Power BI to Azure Synapse Analytics using linked services.
- Design reports and dashboards in Power BI based on the views created in Azure Synapse Analytics.
- Visualize and analyze the data for insights and decision-making.

## Conclusion

By following the outlined steps, the data migration process from on-premise SQL Server to Azure cloud environment can be successfully completed. 
