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
  - # de productos solicitados para cargue.
  - # de productos cargados.
  - # de productos no cargado
- La home page lista los productos que están en base de datos permitiendo hacer clic a un enlace en donde se puede ver el detalle de las variantes.


# Definiciones
- Loader: maneja la carga de productos
  - failed_products: JSON. Almacena un Array con todas las instancias de los productos fallidos.
  - has_many :products
- Product: cada producto guardado exitosamente.
  - name: String. Nombre del producto.
  - description: Text. Descripción del producto.
  - belongs_to :loader
  - has_many :variants
- Variant: variante del producto.
  - name: String. Nombre de la variante (ej. "Talla").
  - price: Float. Precio de la variante (ej. 15.45).

![ERD](https://i.ibb.co/D5Wn3Jv/Deepin-Screenshot-Seleccionar-rea-20200620195050.png)
