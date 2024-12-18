FROM apache/airflow:2.10.4
COPY requirements.txt /
RUN python -m pip install --upgrade pip && pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r /requirements.txt

RUN pip install pytest-playwright && playwright install 
# RUN playwright install-deps

USER root

RUN apt-get update && apt-get install -y \
libglib2.0-0 \                    
libnss3 \                                     
libnspr4 \                                    
libatk1.0-0 \                                 
libatk-bridge2.0-0 \                          
libcups2 \                                    
libdrm2 \                                     
libdbus-1-3 \                                 
libxcb1 \                                     
libxkbcommon0 \                               
libatspi2.0-0 \                               
libx11-6 \                                    
libxcomposite1 \                              
libxdamage1 \                                 
libxext6 \                                    
libxfixes3 \                                  
libxrandr2 \                                  
libgbm1 \                                     
libpango-1.0-0 \                              
libcairo2 \                                   
libasound2 \   
&& rm -rf /var/lib/apt/lists/*


RUN apt update && apt install default-jre -y
