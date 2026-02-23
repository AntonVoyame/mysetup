#!/usr/bin/env zsh

mkdir -p optimizados

for img in *; do
  # Pasamos el nombre a minúsculas temporalmente para leer la extensión de forma segura
  img_lower="${img:l}"

  if [[ "$img_lower" == *.jpg || "$img_lower" == *.jpeg || "$img_lower" == *.png || "$img_lower" == *.webp ]]; then
    nombre_base="${img%.*}"
    echo "Procesando: $img"
    convert "$img" -resize "1920x1080^" -gravity center -extent 1920x1080 -quality 85 "optimizados/$nombre_base.jpg"
  fi
done

echo "¡Optimización completada!"
