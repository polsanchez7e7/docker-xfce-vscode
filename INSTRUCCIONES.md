## 🚀 Cómo usar este entorno

### 🔨 1. Construir y ejecutar el contenedor

Ejecuta el siguiente script:

```
bash
./build_and_run.sh
```

Este script:

1. Construye la imagen `ubuntu-xfce-vscode` usando el `Dockerfile`.
2. Elimina cualquier contenedor anterior llamado `dev-container`.
3. Lanza un nuevo contenedor exponiendo los puertos:

   * **VNC en el puerto 5901**
   * **SSH en el puerto 2222**

Al finalizar verás un mensaje como:

```
✅ Contenidor en execució!
📡 VNC -> localhost:5901 (usuari: developer, contrasenya: vncpassword)
🔐 SSH -> ssh developer@localhost -p 2222 (contrasenya: vncpassword)
```

---

### 📡 2. Conectarte al contenedor vía VNC

Usa tu cliente VNC favorito y conéctate a:

```
localhost:5901
```

* Usuario: `developer`
* Contraseña: `vncpassword`

Una vez dentro, verás el escritorio XFCE.

---

### 🔐 3. Acceso por terminal vía SSH

Puedes acceder por terminal (útil para transferir archivos, instalar herramientas, etc.):

```
ssh developer@localhost -p 2222
```

Contraseña: `vncpassword`

---

### 💻 4. Iniciar Visual Studio Code en entorno gráfico

Debido a que VSCode se basa en Electron (que a su vez usa Chromium), necesita permisos especiales para ejecutarse dentro de un contenedor.

#### ❌ Método incorrecto (no funcionará):

* Buscar y lanzar "Visual Studio Code" desde el menú de XFCE.

#### ✅ Método correcto:

1. Abre una terminal dentro del escritorio XFCE.
2. Ejecuta el siguiente comando:

```
DISPLAY=:1 code --no-sandbox &
```

Este comando lanza VSCode en el entorno gráfico VNC correctamente.

> **Explicación técnica**:
>
> * `DISPLAY=:1` indica al sistema gráfico que use el display que está siendo mostrado por el servidor VNC.
> * `--no-sandbox` es obligatorio porque Chromium no puede usar su sandbox de seguridad dentro de Docker sin privilegios adicionales.

---

## 🌀 Reiniciar el contenedor sin recompilar (script `run.sh`)

Si ya has construido la imagen y simplemente quieres reiniciar el contenedor sin reconstruirlo:

```
./run.sh
```

Este script hace:

```
docker start dev-container
```

y deja el contenedor activo con los puertos VNC y SSH accesibles como antes.

---

## 🧪 Comprobación rápida de acceso

Puedes verificar que el contenedor esté activo y accesible con:

```
docker ps
```

Deberías ver algo como:

```text
CONTAINER ID   IMAGE                ...   PORTS
xxxxxx         ubuntu-xfce-vscode  ...   0.0.0.0:5901->5901/tcp, 0.0.0.0:2222->22/tcp
```

---

## 🔧 Personalización

Si deseas modificar el contenedor (instalar otras herramientas, cambiar configuraciones), puedes:

1. Acceder por SSH o terminal VNC.
2. Hacer los cambios necesarios.
3. Usar `docker commit` si quieres guardar esos cambios como una nueva imagen.

---

## 👤 Usuario preconfigurado

El contenedor incluye un usuario con estas credenciales:

* **Usuario:** `developer`
* **Contraseña:** `vncpassword`
* **Acceso sudo:** Sí (sin contraseña)


## 🧠 Notas finales

* Este contenedor **no guarda los cambios** si lo eliminas. Si necesitas persistencia, monta volúmenes (`-v`) o usa `docker commit`.
* Puedes añadir más puertos, paquetes o configuraciones modificando el `Dockerfile`.

¡Disfruta tu entorno de desarrollo Dockerizado! 💻🐧🚀


