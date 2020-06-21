# Descripción
ViveTest es una aplicación de prueba que se dedica a cargar productos por lote desde un endpoint de su API, muestra los productos en su home page, donde cada producto tiene su vista de detalle donde muestra sus variantes y un dashboard donde se ven todas las peticiones de cargas, la cantidad de productos cargados y la cantidad de productos no cargados (fallidos) durante la carga.

![Products](https://i.ibb.co/wKLmvYR/Deepin-Screenshot-Seleccionar-rea-20200620153548.png)

![Dashboard](https://i.ibb.co/34sSbB9/Deepin-Screenshot-Seleccionar-rea-20200620164503.png)


# Versiones
- Ruby 2.6.6
- Rails 6.0.3


# Gemas utilizadas
```ruby
# Convert html.erb to Haml
gem 'haml-rails', '~> 2.0'

# Requests to APIs
gem 'rest-client'

# Access to Hashes using dot notation
gem 'hash_dot'

# To fix a Draper deprecation error
gem 'activemodel-serializers-xml'
gem 'active_model_serializers'

# Redis server to run tasks in background
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'sidekiq', '~> 5.2.8'
gem 'sinatra', require: nil

# Shim to load environment variables from .env into ENV in development.
gem 'dotenv-rails', groups: %i[development test]

# Generate a diagram based on your application's Active Record models.
gem 'rails-erd', group: :development
```


# Lógica
- La plataforma permite la carga de productos a través de un endpoint de tipo `POST /products`.
- Provee un dashboard que permite ver el estado de cargue de los productos que se han solicitado cargar a través del
API, con los siguientes indicadores:
  - Cantidad de productos solicitados para cargue.
  - Cantidad de productos cargados.
  - Cantidad de productos no cargado
- La home page lista los productos que están en base de datos permitiendo hacer clic a un enlace en donde se puede ver el detalle de las variantes.


# Solución a problemas presentados
- El dashboard es de acceso público. Cualquier persona puede acceder a él sin autenticarse.
- La API es de acceso público. Cualquier persona puede crear productos a través del endpoint `POST https://anyelo-vive-test-rails-6.herokuapp.com//products` usando el payload correcto: ![Payload](https://i.ibb.co/TMvXM4F/Deepin-Screenshot-Seleccionar-rea-20200620200744.png) 
- La App usa dos Jobs, `ProductsPayloadJob` que se encarga de procesar el payload cargado y `ProductCreatorJob` que se encarga de crear cada producto como una petición por separado, los cuales están diseñados para atender múltiples llamados a la API por segundo, donde cada llamado al API puede tener un payload con diferentes productos, desde 0 hasta 10.000 productos.
- La solución está desplegada en Heroku (https://anyelo-vive-test-rails-6.herokuapp.com/) donde se instaló un AddOn para ejecutar Redis


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
  - Validaciones:
    - `validates_presence_of :name, :description`
- Variant: variante del producto.
  - Campos de base de datos:
    - `name`: String. Nombre de la variante (ej. "Talla").
    - `price`: Float. Precio de la variante (ej. 15.45).
  - Relaciones con otros modelos:
    - `belongs_to :product`
  - Validaciones:
    - `validates_presence_of :name, :price`
    - `validates_numericality_of :price, greater_than: 0`

![ERD](https://i.ibb.co/D5Wn3Jv/Deepin-Screenshot-Seleccionar-rea-20200620195050.png)
