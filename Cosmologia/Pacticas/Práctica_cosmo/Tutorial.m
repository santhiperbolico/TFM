
%En este tutorial veremos los comandos necesarios para realizar la
%practica. Copiad los comandos y pegadlos en el workspace para ejecutarlos.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VECTORES Y MATRICES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%En esta seccion veremos ejemplos de los distintos comandos que usaremos
%con vectores y matrices. Lo primero, vemos como definir un vector y
%extraer de el elementos.

v = [4 5 6]

%Para extraer un elemento concreto, por ejemplo el segundo:

a = v(2)

%Si queremos extraer un intervalo, por ejemplo los primeros dos elementos:

b = v(1:2)

%Para extraer el valor minimo (para el maximo es igual solo que con la
%funcion max) de un vector usamos la funcion min. Nos devuelve el valor
%minimo y la posicion del vector en la que esta.

[vmin, I] = min(v)

%En muchas ocasiones es necesario crear vectores con un tamaño determinado
%cuyos elementos vamos a rellenar en un bucle, para ello es util definir un
%vector de ceros con un determinado tamaño.

v = zeros(1,5)

%En otras ocasiones, queremos un vector con N elementos que recorran un
%determinado intervalo de valores, por ejemplo, de 0 a 3.

N = 5;
v = linspace(0,3,N)

%A veces nos interesa conocer el tamaño de un vector.

Size = length(v)

%Con todo ello, una estructura muy util para evaluar una funcion en un
%intervalo determinado es la siguiente.

x = linspace(0,3,5)
y = zeros(1,length(x))

for i = 1:length(x)
    
    y(i) = x(i)^2
    
end

%Por supuesto esta función podemos evaluarla de forma sencilla usando
%calculo con vectores.

x = linspace(0,3,5)
y = x.^2

%En general hay que intentar hacerlo asi, pero en ocasiones no es posible
%y es necesario usar la estructura anterior.

%Por ultimo, vemos como sumar todos los elemementos de un vector.

v = [6 7 8]
sumv = sum(v)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCIONES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Vamos a ver como definir una funcion en la linea de comandos. Para ello
%definimos la funcion sencilla: f(x,y,z) = x*(x + y^3).

f = @(x,y) (x*(x + y^3))

%Si queremos que las variables (x,y,z) puedan ser vectores, debemos de
%definir las operaciones con (x,y,z) como si fuesen vectores.

f = @(x,y) (x.*(x + y.^3))

%De este modo, si evaluamos la funcion en vectores obtenemos un vector.

x = [1 2 3]
y = [5 6 7]

z = f(x,y)

%Para la practica también es util definir una funcion integral del tipo
%f(x) = int_0^x g(x') dx'. Esto lo podemos hacer de la siguiente forma.

g = @(x) (3*x^2)
xmax = 3
f = @(x) (integral(@(qx)heaviside(x-qx)*g(qx),0,xmax,'ArrayValued',true,'RelTol',1e-2))
eval = f([1 2 3])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GRAFICOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Por ultimo, vamos a ver como realizar graficos en matlab. Lo primero vamos
%a cargar los datos de supernovas "Union2.mat" y representar las magnitudes
%aparentes con sus errores.

load('Union2.mat')

errorbar(z,m,dm,'.')
xlabel('z')
ylabel('\mu (z)')

%Tambien vamos a tener que realizar graficos de nivel. Como ejemplo, vamos
%a obtener las curvas de nivel de Z = (X-1)^2 + Y^2 que distan 
%\Delta Z = [1 2 3] del minimo.

N = 100;
x = linspace(-1, 3, N);
y = linspace(-2, 2, N);
[X, Y] = meshgrid(x, y);

Z = zeros(length(y),length(x));

for i=1:length(x)
    
    for j=1:length(y)
        
        Z(j,i) = (x(i)-1)^2 + y(j)^2;
        
    end
    
end

[zmin, I] = min(Z(:));
[I_row, I_col] = ind2sub(size(Z), I);

xmin = x(I_col)
ymin = y(I_row)

v = zmin + [1 2 3];

contour(X,Y,Z,v)
colormap winter
hold on
plot(xmin,ymin,'o')

xlabel('x')
ylabel('y')







