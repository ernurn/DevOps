#Optional Task Day 1

## Reflexión personal
###¿Qué significa DevOps para vos después de esta lección?
DevOps es una metodología que integra el desarrollo de software y las operaciones de TI con el objetivo de acortar el ciclo de vida del desarrollo, aumentar la calidad del software y entregar valor continuo al cliente. DevOps promueve la colaboración, la automatización y la monitorización continua en todas las etapas del desarrollo y la entrega de software.

###¿Qué herramientas ya conocías y cuáles son nuevas?
Las herramientas que conozco son:
- Linux / Bash
- Docker
- Python
- AWS (Hice la certificacion cloud practitioner)

Las herramientas que desconozco son:
- Kubernetes
- Nginx
- Terraform
- Ansible
- Otras

## Primeros Pasos en Linux
### Probar comandos básicos
- whoami -> evn
- pwd -> /home/evn/DevOps/Week_01/Day_01
- ls -lah -> 
total 24K
drwxrwxr-x 2 evn evn 4.0K Jun 11 15:55 .
drwxrwxr-x 3 evn evn 4.0K Jun 11 15:39 ..
-rw-rw-r-- 1 evn evn  737 Jun 11 15:55 Optional_task.md
-rw-r--r-- 1 evn evn  12K Jun 11 15:57 .Optional_task.md.swp

- mkdir devops-d1 -> crea directorio devops-01
- cd devops-d1 -> change directory devops-d1
- echo "Hola DevOps" > hola.txt -> Crea archivo hola.txt con el texto "Hola DevOps"
- cat hola.txt -> muestra en pantalla el contenido del archivo hola.txt

## Desafío: ¡Linux Detectives!
### ¿Cuánto tiempo lleva encendido tu sistema?
16:05:51 up  1:13,  1 user,  load average: 0.42, 0.42, 0.44

### ¿Qué procesos están consumiendo más recursos?
top - 16:07:00 up  1:14,  1 user,  load average: 0.47, 0.46, 0.45
Tasks: 235 total,   1 running, 234 sleeping,   0 stopped,   0 zombie
%Cpu(s):  3.1 us,  6.8 sy,  0.0 ni, 87.2 id,  0.0 wa,  0.0 hi,  2.8 si,  0.0 st 
MiB Mem :   3914.9 total,    749.4 free,   1795.1 used,   1685.2 buff/cache     
MiB Swap:   3915.0 total,   3915.0 free,      0.0 used.   2119.8 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND  
   2750 evn       20   0 4851936 423708 172320 S  57.4  10.6   6:52.50 /usr/bi+ 
   3609 evn       20   0 3231136 500672 201120 S  13.5  12.5   4:16.71 /snap/f+ 
   3585 evn       20   0  556908  55080  42724 S   5.3   1.4   0:23.44 /usr/li+ 
   4355 evn       20   0 2476976 142900  94968 S   5.3   3.6   0:43.63 /snap/f+

### ¿Cuánta memoria disponible tenés?
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       1.8Gi       745Mi        80Mi       1.6Gi       2.1Gi
Swap:          3.8Gi          0B       3.8Gi





