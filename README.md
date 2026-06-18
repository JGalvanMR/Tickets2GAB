# 📦 Nombre del Módulo: `Tickets2` — Sistema de Gestión de Tickets de Soporte Técnico

---

## 🧭 Propósito

`Tickets2` es una aplicación web ASP.NET Web Forms (.NET 4.5) que gestiona solicitudes de soporte técnico interno para mrlucky.com.mx (Comercializadora GAB). Permite a los empleados registrar incidentes dirigidos a dos departamentos de atención: **Sistemas** y **Mantenimiento**, y a los administradores de cada departamento gestionar el ciclo de vida completo de esas solicitudes —asignación, seguimiento mediante comentarios, carga de evidencias fotográficas y cierre formal—, con notificaciones por correo electrónico en cada transición de estado.

---

## ⚙️ Responsabilidades

- Autenticar usuarios con tres roles distintos: Usuario final, Administrador de Sistemas y Administrador de Mantenimiento.
- Permitir a usuarios finales levantar solicitudes de soporte, adjuntar hasta 5 fotografías de evidencia y agregar comentarios en tickets activos propios.
- Permitir a administradores asignar responsables, establecer fechas estimadas de finalización, agregar comentarios y cerrar tickets de su departamento.
- Mostrar monitores de solo lectura con el estado actual de tickets (Sistemas y Mantenimiento), con auto-refresco periódico.
- Enviar notificaciones automáticas por correo electrónico al crear, asignar, comentar y finalizar un ticket.
- Registrar y administrar el catálogo de usuarios (personas, cuentas, roles y departamentos).
- Escalar y almacenar fotografías de evidencia en sistema de archivos local/red.
- Consumir un segundo base de datos (`GAB_Irapuato`) para obtener el catálogo de empleados de mantenimiento y el catálogo de equipos por área.

---

## 🔄 Flujo de Funcionamiento

**1. Autenticación (`PaginaLogin.aspx`)**
El usuario selecciona su rol (Usuario, Admin Sistemas, Admin Mantenimiento) e ingresa credenciales. El sistema valida contra la tabla `Usuario` con join a `Persona`, `Trabajador` o `Administrador` según el rol, verificando además `per_IsActivo = true` y, para administradores, el `dep_ID` específico (1 = Sistemas, 5 = Mantenimiento). Al autenticar, almacena el objeto `Usuario` en una variable de sesión y redirige a la página correspondiente.

**2. Creación de Ticket (`Usuario.aspx`)**
El usuario autenticado selecciona el departamento destino (`SISTEMAS` o `MANTENIMIENTO`). Si selecciona Mantenimiento, se habilitan los combos de Área y Equipo, poblados desde `GAB_Irapuato`. El usuario ingresa la descripción del incidente y opcionalmente adjunta hasta 5 fotos. Al guardar, el sistema calcula el nuevo `ser_ID` como `MAX(ser_ID)+1`, inserta el registro en estado `Solicitado (1)`, guarda las imágenes escaladas a máximo 405px de alto en `~/FotosManto/`, y envía correo de notificación al departamento correspondiente.

**3. Asignación de Responsable (`Administrador.aspx` / `AdminManto.aspx`)**
El administrador ingresa el ID del ticket (debe estar en estado `Solicitado`), selecciona el responsable del combo correspondiente y una fecha estimada de finalización. El sistema valida que el ticket pertenezca a su departamento (`ser_DeptoQueAtiende == objAdmin.Persona.dep_ID`), actualiza el estado a `Abierto (2)`, registra el nombre del responsable en `ser_Nombre_Atiende` y envía correo de notificación de asignación.

**4. Comentarios**
Tanto usuarios finales como administradores pueden agregar comentarios a tickets en estado `Abierto` o `Finalizado`. El sistema valida que el ticket no esté en estado `Solicitado` y que el comentario pertenezca al ámbito del actor (el usuario debe ser quien levantó el ticket; el administrador debe ser del departamento que atiende). Inserta un registro en `Comentario` con `com_ID = MAX+1` y envía correo de notificación.

**5. Carga de Fotos de Evidencia Final**
Disponible para administradores en tickets con estado `Abierto` o `Finalizado`. Las fotos se almacenan en `~/FotosManto/Finalizado/` (Sistemas) o `\\Gabira1\FotosManto\Finalizado\` (Mantenimiento) y se incrementa el contador `ser_Num_Fotos` en la tabla `Servicio`.

**6. Finalización de Ticket**
El administrador ingresa el ID del ticket, que debe estar en estado `Abierto` y pertenecer a su departamento. El sistema actualiza el estado a `Finalizado (3)`, registra `ser_FechaUltimoE = DateTime.Now` y envía correo de cierre con enlace a encuesta de satisfacción (solo en Sistemas).

**7. Monitores de Lectura (`MonitorTickets.aspx`, `MonitorMantenimiento.aspx`)**
Accesibles sin autenticación. Cargan y muestran en tiempo cuasi-real los tickets por estado. `MonitorTickets.aspx` incluye filtro de finalizados por ID de usuario y paginación. Ambos monitores se auto-refrescan por JavaScript (300 000 ms y 120 000 ms respectivamente).

---

## 📐 Reglas de Negocio

### 🔒 Restricciones

- **R1:** Un usuario solo puede comentar tickets que él mismo levantó (`per_ID_Levanto == objUser.Persona.per_ID`).
- **R2:** Un administrador solo puede gestionar (asignar, comentar, cargar fotos, finalizar) tickets cuyo `ser_DeptoQueAtiende` coincida con el `dep_ID` de su persona.
- **R3:** El rol Admin Sistemas requiere `dep_ID = 1` en la tabla `Persona`; el rol Admin Mantenimiento requiere `dep_ID = 5`.
- **R4:** Solo se pueden subir máximo 5 fotografías por operación de carga.
- **R5:** No se puede agregar un comentario a un ticket en estado `Solicitado (1)`.
- **R6:** No se puede finalizar un ticket que no esté en estado `Abierto (2)`.
- **R7:** No se puede asignar responsable a un ticket que no esté en estado `Solicitado (1)`.
- **R8:** Un usuario inactivo (`per_IsActivo = false`) no puede autenticarse en ningún rol.

### ✅ Validaciones

- **V1:** Los campos Nombre, Apellido Paterno, Apellido Materno, Email, Teléfono, Nombre de usuario y Contraseña son obligatorios al registrar un nuevo usuario.
- **V2:** El campo Incidente es obligatorio al levantar un servicio.
- **V3:** El Departamento destino es obligatorio al levantar un servicio.
- **V4:** El ID del servicio en operaciones administrativas debe ser un número entero válido y no vacío.
- **V5:** El campo de Comentario no puede estar vacío al agregar uno.
- **V6:** La fecha estimada de finalización es obligatoria al asignar un responsable.
- **V7:** La selección de responsable en el combo es obligatoria al asignar.
- **V8:** Al cargar fotos se valida que el ID de servicio sea entero y que se hayan seleccionado archivos.
- **V9:** Al cambiar contraseña: la contraseña actual debe coincidir con la almacenada, y la nueva contraseña debe confirmarse correctamente.

### 🔁 Agrupaciones / Estados

- **E1:** El ciclo de vida de un ticket sigue estrictamente la secuencia: `Solicitado (1)` → `Abierto (2)` → `Finalizado (3)`. No existe retroceso de estados.
- **E2:** Los tickets se segregan por departamento destino (`ser_DeptoQueAtiende`): dep_ID 1 = Sistemas, dep_ID 5 = Mantenimiento.
- **E3:** Los combos de Área y Equipo en la creación de tickets solo aplican y se habilitan cuando el departamento destino es Mantenimiento (dep_ID = 5).

### ⚙️ Reglas Operativas

- **O1:** El ID de nuevo `Servicio`, `Comentario`, `Persona`, `Usuario`, `Trabajador` y `Administrador` se calcula como `MAX(ID_columna) + 1` en el momento de la inserción.
- **O2:** La fecha del último estado (`ser_FechaUltimoE`) se actualiza a `DateTime.Now` en asignación y finalización.
- **O3:** Las fotografías se reescalan proporcionalmente a una altura máxima de 405 píxeles antes de guardarse en JPEG.
- **O4:** La ruta de almacenamiento de fotos "antes" es `~/FotosManto/` (Sistemas) o `\\Gabira1\FotosManto\` (Mantenimiento); las fotos "después" van a `~/FotosManto/Finalizado/` o `\\Gabira1\FotosManto\Finalizado\`.
- **O5:** El nombre del archivo de foto se construye como `{ser_ID}{número_secuencial}.jpg`, donde el número secuencial continúa desde el valor actual de `ser_Num_Fotos`.
- **O6:** Los correos de Sistemas se envían desde `sistemas@mrlucky.com.mx` vía SMTP `mail1.mrlucky.com.mx:587` con TLS. Las credenciales SMTP están hardcodeadas en el código.
- **O7:** El correo de finalización (solo Sistemas) incluye un enlace a encuesta de satisfacción parametrizado con el `ser_ID`.
- **O8:** Los responsables de Sistemas se obtienen de personas de `dep_ID = 1` con `per_IsActivo = true` en `Tickets2`. Los responsables de Mantenimiento se obtienen de `tb_man_cat_empleado` en `GAB_Irapuato` filtrando `estatus_empleado = 'A'`.
- **O9:** La columna `per_copia` en `Persona` define correos adicionales en CC para notificaciones del usuario que levanta o recibe el servicio.
- **O10:** El monitor `MonitorTickets.aspx` es de acceso público (no requiere sesión). `MonitorMantenimiento.aspx` igualmente.

---

## 🔗 Dependencias

| Tipo | Nombre | Uso |
|---|---|---|
| Framework | ASP.NET Web Forms 4.5 | Infraestructura de páginas y controles |
| ORM | LINQ to SQL (`dcTicketsDataContext`) | Acceso a base de datos `Tickets2` |
| Base de datos | SQL Server `Tickets2` @ `192.168.123.6:1433` | Base de datos principal (tickets, personas, usuarios) |
| Base de datos externa | SQL Server `GAB_Irapuato` @ `192.168.123.6:1433` | Catálogo de empleados de mantenimiento y equipos por área |
| Librería JS | Bootstrap 3 (múltiples versiones: `bootstrap.min.css`, `bootstrap.min2.css`) | UI responsiva |
| Librería JS | jQuery 2.1.3 / 2.1.1 | Manipulación DOM y AJAX |
| Librería JS | `bootstrap-datetimepicker.js` con `moment.js` | Selector de fecha/hora en formularios admin |
| Librería JS | `fileinput.js` | Control de carga múltiple de archivos |
| Librería JS | `fancyTable.js` | Búsqueda y paginación cliente en grid de finalizados de Sistemas |
| CDN externo | `ajax.googleapis.com` (jQuery 2.1.1) | Cargado por HTTP sin TLS |
| CDN externo | `cdnjs.cloudflare.com` (jQuery 3.3.1, moment.js) | Dependencia de red externa |
| Sistema de archivos | `~/FotosManto/` y `\\Gabira1\FotosManto\` | Almacenamiento de fotografías |
| Namespace interno | `Datos` (proyecto clase `Datos.csproj`) | Modelos LINQ to SQL y enum de estados |
| Namespace interno | `Tickets2.MessageBox` | Clase utilitaria para alertas JavaScript en postback |
| SMTP | `mail1.mrlucky.com.mx:587` | Envío de notificaciones por correo |

---

## ⚠️ Riesgos Técnicos

**RT-01 — Credenciales SA hardcodeadas (CRÍTICO)**
La cadena de conexión usa `User ID=sa;Password=Gabira2026$` embebida directamente en `Settings.Designer.cs`, `app.config`, `Web.config` implícito y en múltiples `SqlConnection` inline en código C#. Comprometer el código fuente equivale a comprometer la base de datos completa con privilegios de superadministrador.

**RT-02 — SQL Injection (CRÍTICO)**
En `Usuario.aspx.cs`, los métodos `CargarCmbArea()`, `CargarCmbEquipos()` y `cmbArea_SelectedIndexChanged()` construyen sentencias SQL concatenando directamente `cmbArea.SelectedValue` sin parametrización. Un valor manipulado en el combo puede ejecutar SQL arbitrario contra `GAB_Irapuato`.

**RT-03 — Contraseñas en texto plano (ALTO)**
La tabla `Usuario` almacena `usu_Password` sin hash ni cifrado. Cualquier acceso a la base de datos expone todas las contraseñas. El proceso de cambio de contraseña también opera en texto plano.

**RT-04 — Race condition en generación de IDs (ALTO)**
El patrón `MAX(ID)+1` para calcular nuevos IDs de `Servicio`, `Comentario`, `Persona`, etc., no es atómico. Dos inserciones concurrentes pueden obtener el mismo `MAX` y provocar violación de clave primaria o duplicados silenciosos, ya que en algunos casos el ID se calcula antes de adquirir el lock de inserción.

**RT-05 — Acoplamiento con ID de departamento hardcodeado (ALTO)**
Los valores `dep_ID = 1` (Sistemas) y `dep_ID = 5` (Mantenimiento) están dispersos en al menos 8 puntos del código fuente. Un cambio en los datos de la tabla `Departamento` rompería silenciosamente la lógica de autenticación y filtrado de tickets sin error de compilación.

**RT-06 — Ausencia de protección CSRF (ALTO)**
Las páginas Web Forms no implementan ViewState validation token personalizado ni tokens anti-CSRF explícitos. Las acciones destructivas (finalizar ticket, cambiar contraseña) son vulnerables a ataques de falsificación de solicitud entre sitios.

**RT-07 — Almacenamiento de fotos en ruta de red sin validación de tipo (MEDIO)**
Las fotografías en `AdminManto.aspx` se guardan en `\\Gabira1\FotosManto\` asumiendo disponibilidad del share de red. No se valida la extensión ni el tipo MIME del archivo subido, solo su `ContentLength > 0`. Es posible subir archivos ejecutables.

**RT-08 — Gestión de sesión sin timeout explícito ni renovación segura (MEDIO)**
La autenticación se basa únicamente en `Session["objUser/objAdmin/objAdminMan"]`. No se configura timeout de sesión, no se invalida el token en el servidor al cerrar sesión de forma forzada, y el logout solo asigna `null` a la variable de sesión.

**RT-09 — Dependencia de CDN externo por HTTP (MEDIO)**
`Administrador.aspx` y `Usuario.aspx` cargan jQuery desde `http://ajax.googleapis.com` sin TLS. Esto expone la página a ataques man-in-the-middle que pueden inyectar JavaScript malicioso.

**RT-10 — `MessageBox` con estado compartido no thread-safe (MEDIO)**
La clase `MessageBox` usa un `Hashtable` estático (`m_executingPages`) compartido entre todas las solicitudes concurrentes. Bajo carga, múltiples hilos pueden leer y escribir simultáneamente sin sincronización, causando comportamientos impredecibles o excepciones.

**RT-11 — Múltiples versiones de Bootstrap cargadas simultáneamente (BAJO)**
Varias páginas cargan `bootstrap.min.css` y `bootstrap.min2.css` junto con múltiples versiones de `bootstrap.min.js`, lo que provoca sobrescritura de estilos y comportamientos impredecibles en componentes JS.

**RT-12 — `System.Drawing` para procesamiento de imágenes (BAJO)**
El namespace `System.Drawing` (GDI+) está marcado como no recomendado para uso en aplicaciones web desde .NET Core por problemas de estabilidad bajo carga concurrente. En .NET 4.5 con IIS puede generar corrupciones de imagen en escenarios de alta concurrencia.

---

## 🧪 Casos Edge

- **CE-01:** Si la tabla `Comentario` está vacía cuando un usuario intenta insertar el primer comentario, `queryComentarMan.First()` lanza excepción en `AdminManto.aspx`. En `Administrador.aspx` y `Usuario.aspx` este caso está cubierto con try/catch, pero en `AdminManto.aspx` el primer comentario puede fallar.
- **CE-02:** Si `ser_Num_Fotos` es `NULL` en base de datos (por ejemplo, tickets creados antes de que existiera la columna), `Convert.ToInt32(null)` retorna `0`, lo que es correcto; sin embargo no se valida que el total de fotos acumuladas no supere 5.
- **CE-03:** El filtro de búsqueda en `MonitorTickets.aspx` solo aplica a la carga del grid de Finalizados; al cambiar de página (`dgFinalizados_PageIndexChanging`), toma el valor actual del TextBox, que puede estar vacío si el usuario no escribió nada antes de paginar.
- **CE-04:** En `btnGuardar_Click` de `Usuario.aspx`, `EnviarCorreo()` se llama antes de `dcDatos.Servicio.InsertOnSubmit(objServ)`. Si el envío de correo falla con excepción no capturada (la `SmtpException` está capturada internamente, pero otras excepciones no), el ticket no se insertará, pero el correo pudo haberse enviado parcialmente.
- **CE-05:** El cálculo del número de ticket en `EnviarCorreo()` (`MAX+1`) puede diferir del `ser_ID` real asignado si ocurre una inserción concurrente entre la llamada al correo y el `SubmitChanges()`, resultando en un número de ticket incorrecto en el correo de notificación.
- **CE-06:** Si `per_copia` en `Persona` contiene una cadena con múltiples correos separados por coma pero con espacios, `message.CC.Add()` puede fallar o enviar a destinatarios incorrectos dependiendo de la implementación de `MailMessage`.
- **CE-07:** El monitor `MonitorMantenimiento.aspx` no requiere autenticación y se auto-refresca cada 120 segundos. Si la sesión de IIS expira o el servidor se reinicia, la página continúa mostrando datos en modo monitor sin impacto, pero tampoco muestra error al usuario si la BD no está disponible.
- **CE-08:** Al registrar un nuevo usuario en `Administrador.aspx`, se insertan secuencialmente `Persona`, `Usuario` y `Trabajador/Administrador` sin transacción envolvente. Si falla la segunda o tercera inserción, queda un registro huérfano en `Persona` o `Usuario`.

---

## 🧱 Suposiciones Detectadas

- **S1:** El sistema asume que `dep_ID = 1` siempre corresponde a Sistemas y `dep_ID = 5` siempre corresponde a Mantenimiento. Esto nunca se verifica dinámicamente.
- **S2:** Se asume que siempre existe al menos una persona activa en `dep_ID = 1` con correo registrado para las notificaciones CC de administración de Sistemas (la consulta `correodes` itera sin verificar que el resultado no sea vacío antes de agregar al CC).
- **S3:** Se asume que los IDs de `Servicio`, `Comentario`, etc. son únicos y no se gestionan mediante identidad de base de datos (`IDENTITY`), sino mediante cálculo manual `MAX+1`.
- **S4:** Se asume que el servidor IIS tiene acceso de escritura permanente al share de red `\\Gabira1\FotosManto\` para el módulo de Mantenimiento.
- **S5:** Se asume que los combo de departamento en `cmbAsignar.SelectedItem.ToString().Trim()` siempre devolverán exactamente `"SISTEMAS"` o `"MANTENIMIENTO"` (comparación case-sensitive por texto visible, no por ID).
- **S6:** Se asume que la fecha del `datetimepicker4` siempre llega en formato `dd/MM/yyyy`, y el código la reordena como `MM/dd/yyyy` para `Convert.ToDateTime()`. Cualquier otro formato causará excepción.
- **S7:** Se asume que `HttpFileCollection uploadedFiles = Request.Files` contiene exactamente los archivos seleccionados por el usuario, sin validación de que realmente son imágenes.
- **S8:** Se asume que `cmbAsignar` siempre tiene un valor seleccionado en `EnviarCorreoComentario()`, ya que se accede a `cmbAsignar.SelectedValue` sin verificar que no sea `-1`.

---

## 📈 Recomendaciones Técnicas

**REC-01 (CRÍTICO):** Migrar las cadenas de conexión a `Web.config` con cifrado de sección `<connectionStrings>` usando `aspnet_regiis -pe`, eliminar el usuario `sa` y crear un usuario SQL de menor privilegio específico para la aplicación.

**REC-02 (CRÍTICO):** Reemplazar las concatenaciones de SQL en `CargarCmbArea()`, `CargarCmbEquipos()` y `cmbArea_SelectedIndexChanged()` por `SqlParameter` o consultas LINQ parametrizadas.

**REC-03 (CRÍTICO):** Aplicar hashing de contraseñas con `PBKDF2` o `BCrypt` antes de almacenar en `usu_Password`. Migrar contraseñas existentes en la próxima autenticación exitosa.

**REC-04 (ALTO):** Reemplazar el patrón `MAX+1` por columnas `IDENTITY` en SQL Server para todos los IDs primarios, eliminando la race condition y simplificando el código de inserción.

**REC-05 (ALTO):** Centralizar los valores de departamento en constantes o tabla de configuración, eliminando los literales `1` y `5` dispersos en el código. Ejemplo: `const int DEP_SISTEMAS = 1;` en una clase de configuración.

**REC-06 (ALTO):** Envolver las secuencias de inserción múltiple (registro de usuario: Persona + Usuario + Trabajador/Administrador) en `TransactionScope` para garantizar atomicidad.

**REC-07 (ALTO):** Reemplazar el formato de fecha `Split('/')` por `DateTime.TryParseExact()` con cultura `es-MX` para parseo robusto de la fecha del datepicker.

**REC-08 (MEDIO):** Implementar validación de tipo MIME y extensión en las subidas de archivos, aceptando únicamente `image/jpeg`, `image/png` y verificando el magic number del archivo.

**REC-09 (MEDIO):** Reemplazar `System.Drawing` por `ImageSharp` (SixLabors) o `SkiaSharp` para el redimensionamiento de imágenes, que son thread-safe y están activamente mantenidas.

**REC-10 (MEDIO):** Migrar las dependencias de CDN a versiones HTTPS o, preferentemente, incluirlas localmente (ya existen archivos locales en la carpeta `js/` para la mayoría).

**REC-11 (MEDIO):** Reemplazar la clase `MessageBox` estática con `Hashtable` no thread-safe por `ScriptManager.RegisterStartupScript()` directo en cada Page, que es el patrón seguro y estándar en Web Forms.

**REC-12 (BAJO):** Consolidar en una única versión de Bootstrap (preferentemente 3.4.x por retrocompatibilidad con el JS existente) y eliminar los archivos duplicados `bootstrap.min2.css/js`.

---

## 🧾 Resumen Ejecutivo

`Tickets2` es el sistema interno de soporte técnico de Comercializadora GAB, utilizado por los empleados de mrlucky.com.mx para reportar fallas o requerimientos de asistencia dirigidos a dos áreas: **Sistemas** (soporte informático) y **Mantenimiento** (soporte de equipos físicos e instalaciones).

El proceso es sencillo: un empleado reporta un problema a través del portal web, el personal de soporte del área correspondiente lo revisa, asigna a un técnico responsable, registra avances mediante comentarios y fotografías, y finalmente cierra el ticket cuando el problema está resuelto. El sistema notifica automáticamente por correo electrónico a los involucrados en cada paso del proceso.

Desde la perspectiva de negocio, el sistema cumple su función operativa de forma adecuada. Sin embargo, presenta **vulnerabilidades de seguridad significativas** que representan un riesgo real para la organización: las contraseñas de la base de datos están expuestas en el código fuente con acceso de superadministrador, las contraseñas de los usuarios se guardan sin protección, y existen puntos de entrada que podrían permitir accesos no autorizados a los datos de la empresa.

Antes de cualquier expansión funcional, se recomienda priorizar la corrección de estas vulnerabilidades de seguridad y la estabilización de la generación de identificadores, dado que el sistema opera en producción con datos reales de la organización.
