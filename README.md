# 🛡️ MECO Framework
**MECO – Marco de Estandarización de Conocimiento Operativo** *Securing Infrastructure through Automation & Resiliency*

---

## 📖 Overview
MECO es un framework de orquestación de ciberseguridad enfocado en la estandarización de procesos tácticos para entornos empresariales (SOC L1 / Blue Team). Su objetivo es automatizar tareas repetitivas de auditoría y asegurar la integridad de la evidencia recolectada.

* **Automated security auditing**: Escaneos y recolección de datos eficiente con Nmap y Python.
* **CIS-based hardening**: Aplicación de políticas de seguridad y optimización de infraestructura.
* **Evidence generation**: Gestión íntegra de pruebas para auditoría mediante volúmenes persistentes.
* **Reproducible reporting**: Reportes consistentes integrados con la base de conocimientos.

---

## 🏗️ Arquitectura de Infraestructura (SSD Protection & Registry)
Para cumplir con los estándares de **SENATI** y las prácticas en **Owl Perú**, el framework opera sobre un ecosistema optimizado para el rendimiento y la vida útil del hardware:

* **Optimización de Hardware**: Implementación de un **RAM-Shield (tmpfs)** de 2.0 GB montado en `/tmp`. Esto elimina el desgaste del SSD (Kingston KC600) al procesar datos volátiles y acelera las herramientas de análisis.
* **Container Registry**: El entorno (Kali Personalizado con Python 3.13 y Nmap) es inmutable y se aloja en el registro privado de GitLab para portabilidad total.
    * **Image Digest**: `sha256:62caa2d0cd067a9fc538c069f387d75c54042979a40e39efd1f6839bae33d23c`
* **Persistencia Híbrida**: Sincronización en tiempo real entre el contenedor y el Host (Arch Linux) mediante volúmenes de Docker, permitiendo que el código fuente resida en el SSD y los datos temporales en la RAM.

---

## 📂 Organización del Framework
Basado en la estructura modular v1.0:

* **`01-framework/`**: Núcleo de la automatización. Contiene `access_manager.py` para gestión de permisos y la carpeta `inventory/` para perfiles YAML.
* **`03-analysis/`**: Procesamiento de datos. Incluye `csv_validator.py` para asegurar la integridad de la información recolectada.
* **`05-vault/`**: Seguridad de datos sensibles. Almacena archivos cifrados como `cefop_secrets.yml.gpg` (Secrets Management).
* **`06-evidence/`**: Resultados y auditoría. Contiene `report_engine.py` para la generación automática de reportes.
* **`bin/`**: Punto de entrada del sistema. Contiene el binario ejecutable `meco`.
* **`docs/`**: Documentación técnica detallada y el archivo `PROYECTO_MEJORA.md`.
* **`load_env.sh`**: Script de activación para cargar el entorno Docker y alias en cualquier estación de trabajo.

---

## 🚀 Despliegue Rápido
Para ejecutar el entorno en una máquina nueva con Docker:

1.  **Clonar proyecto**: `git clone <repo_url>`
2.  **Cargar entorno**: `source load_env.sh`
3.  **Iniciar laboratorio**: `meco-kali`

---

## 🧱 Project Status
**MECO v1.0** — Foundation stage (Thesis scope).  
*Configuración de hardware blindada y entorno de contenedores desplegado exitosamente.*

> *A framework does not grow by adding features, it grows by solidifying foundations.*

## Author
Samuell.sr
