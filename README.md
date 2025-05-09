# 🐳 Entorno Docker con XFCE + Visual Studio Code + Python + SSH + VNC

Este proyecto Docker proporciona un entorno de desarrollo completo dentro de un contenedor Linux basado en Ubuntu, ideal para trabajar con herramientas gráficas ligeras como XFCE y Visual Studio Code, accesibles mediante VNC y SSH.

---

## 📦 Características del entorno

- Sistema base: **Ubuntu**
- Entorno gráfico: **XFCE4**
- Editor: **Visual Studio Code**
- Acceso remoto: **VNC y SSH**
- Lenguaje de programación: **Python 3 + pip**
- Usuario preconfigurado: `developer`
- Contraseña por defecto: `vncpassword`

---

## ⚙️ Requisitos previos

Antes de comenzar, asegúrate de tener:

- **Docker instalado**
- Acceso a una terminal con permisos para ejecutar Docker
- Un cliente **VNC** como Remmina, RealVNC, TigerVNC, etc.

---

## 📁 Estructura del repositorio

```plaintext
.
├── build_and_run.sh   # Script para construir la imagen y lanzar el contenedor
├── run.sh             # Script para lanzar un contenedor ya creado
├── Dockerfile         # Define la imagen Docker con todo el entorno
└── README.md          # Esta documentación
