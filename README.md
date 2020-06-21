# Descripción
ViveTest es una aplicación de prueba que se dedica a cargar productos por lote desde un endpoint de su API, muestra los productos en su home page, donde cada producto tiene su vista de detalle donde muestra sus variantes y un dashboard donde se ven todas las peticiones de cargas, la cantidad de productos cargados y la cantidad de productos no cargados (fallidos) durante la carga.

![Products](https://i.ibb.co/wKLmvYR/Deepin-Screenshot-Seleccionar-rea-20200620153548.png)

![Dashboard](https://i.ibb.co/34sSbB9/Deepin-Screenshot-Seleccionar-rea-20200620164503.png)


# Versiones
- Ruby 2.5.1
- Rails 5.2


# Gemas utilizadas
```ruby
# Convert html.erb to Haml
gem 'haml-rails', '~> 2.0'

# Requests to APIs
gem 'rest-client'

# Access to Hashes using dot notation
gem 'hash_dot'

# To fix a Draper deprecation error
gem 'active_model_serializers'
```


# Lógica
- La plataforma permite la carga de productos a través de un endpoint de tipo `POST /products`.
- Provee un dashboard que permite ver el estado de cargue de los productos que se han solicitado cargar a través del
API, con los siguientes indicadores:
  - Cantidad de productos solicitados para cargue.
  - Cantidad de productos cargados.
  - Cantidad de productos no cargado
- La home page lista los productos que están en base de datos permitiendo hacer clic a un enlace en donde se puede ver el detalle de las variantes.


# Definiciones
- Loader: maneja la carga de productos
  - Campos de base de datos:
    - `failed_products`: JSON. Almacena un Array con todas las instancias de los productos fallidos.
  - Relaciones con otros modelos:
    - `has_many :products`
  - Métodos personalizados:
    - `total_products`: la suma de los productos creados más los productos fallidos de esta carga solicitada.
    - `self.total_products`: la suma total de todos los productos creados más todos los productos fallidos de todas las cargas solicitadas.
    - `self.failed_products`: todos los productos fallidos de todas las cargas solicitadas.
- Product: cada producto guardado exitosamente.
  - Campos de base de datos:
    - `name`: String. Nombre del producto.
    - `description`: Text. Descripción del producto.
  - Relaciones con otros modelos:
    - `belongs_to :loader`
    - `has_many :variants`
- Variant: variante del producto.
  - Campos de base de datos:
    - `name`: String. Nombre de la variante (ej. "Talla").
    - `price`: Float. Precio de la variante (ej. 15.45).
  - Relaciones con otros modelos:
    - `belongs_to :product`

![ERD](https://i.ibb.co/D5Wn3Jv/Deepin-Screenshot-Seleccionar-rea-20200620195050.png)
