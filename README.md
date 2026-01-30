# 🛡️ MECO Framework
**MECO – Marco de Estandarización de Conocimiento Operativo** *Securing Infrastructure through Automation & Resiliency*

---

## 📖 Overview
MECO es un framework de orquestación de ciberseguridad enfocado en la estandarización de procesos tácticos para entornos empresariales:

* **Automated security auditing**: Escaneos y recolección de datos eficiente.
* **CIS-based hardening**: Aplicación de políticas de seguridad robustas.
* **Evidence generation**: Gestión íntegra de pruebas para auditoría.
* **Reproducible reporting**: Reportes consistentes para la toma de decisiones.

---

## 🏗️ Arquitectura de Infraestructura (SSD Protection & Registry)
Para cumplir con los estándares de **SENATI** y las prácticas en **Owl Perú**, el framework opera sobre un ecosistema optimizado:

* **Optimización de Hardware**: Implementación de un **Ramdisk (tmpfs)** de 2.0 GB montado en `/tmp`. Esto elimina el desgaste del SSD al procesar datos volátiles y acelera las herramientas de análisis.
* **Container Registry**: El entorno (Kali Personalizado) es inmutable y se aloja en el registro privado de GitLab.
    * **Image Digest**: `sha256:....7390dc`
* **Persistencia Híbrida**: Sincronización en tiempo real entre el contenedor y el Host (Arch Linux) mediante volúmenes de Docker.

---

## 📂 Organización del Framework
* **`01-framework/`**: Lógica de automatización y scripts en Python.
* **`03-analysis/`**: Módulos de análisis de tráfico y vulnerabilidades.
* **`05-vault/`**: Base de conocimientos (CyberBrain en Obsidian).
* **`06-evidence/`**: Almacén centralizado de hallazgos y reportes.

---

## 🧱 Project Status
**MECO v1.0** — Foundation stage (Thesis scope).

> *A framework does not grow by adding features, it grows by solidifying foundations.*

## Author
Samuell.sr
