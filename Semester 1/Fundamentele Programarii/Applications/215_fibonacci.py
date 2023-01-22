def teste_fibonacci(fibo_fun,file_name):
	lista_nr_pasi=[]
	fibonacci = [1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040]
	for i in range(len(fibonacci)):
		assert(fibo_fun(i+1,lista_nr_pasi)==fibonacci[i])
	with open(file_name,"w") as f:
		for nr,nr_pasi in lista_nr_pasi:
			f.write(str(nr_pasi)+"\n")

def fibo_rec(n):
	if n==0 or n==1:
		return n,1
	n1,nr_pasi1 = fibo_rec(n-2)
	n2,nr_pasi2 = fibo_rec(n-1)
	return n1+n2,nr_pasi1+nr_pasi2+2

def fibo_v0(n,lista_nr_pasi):
	nr,nr_pasi = fibo_rec(n)
	lista_nr_pasi.append((n,nr_pasi))
	return nr

def fibo_v1(n,lista_nr_pasi):
	ant = 0
	cur = 1
	if n== 1:
		lista_nr_pasi.append((1,1))
		return 1
	nr_pasi = 1
	for i in range(n-1):
		aux = ant+cur
		ant = cur
		cur = aux
		nr_pasi += 1
	lista_nr_pasi.append((n,nr_pasi))
	return cur

import math

def putere(x,n):
	if n == 0:
		return 1
	if n == 1:
		return x
	r = putere(x,n//2)
	if n % 2 == 0:
		return r*r
	return r*r*x

def mul_mat(a,b):
	c = [[0,0],[0,0]]
	c[0][0] = a[0][0]*b[0][0]+a[0][1]*b[1][0]
	c[0][1] = a[0][0]*b[0][1]+a[0][1]*b[1][1]
	c[1][0] = a[1][0]*b[0][0]+a[1][1]*b[1][0]
	c[1][1] = a[1][0]*b[0][1]+a[1][1]*b[1][1]
	return c
	

def putere_mat(mat,p):
	if p == 0:
		return ([[1,0],[0,1]],1)
	if p == 1:
		return ([[mat[0][0],mat[0][1]],[mat[1][0],mat[1][1]]],1)
	r,nr_pasi = putere_mat(mat,p//2)
	rr = mul_mat(r,r)
	if p % 2 == 0:
		return (rr,nr_pasi+1)
	return (mul_mat(rr,mat),nr_pasi+1)

def sqrt(x,n,eps):
	st = 0
	dr = x
	m = (st+dr)/2
	mm = putere(m,n) - x
	while abs(mm)>eps:
		if mm<0:
			st = m
		if mm>0:
			dr = m
		m = (st+dr)/2
		mm = putere(m,n) - x
	return m 

def teste_radical():
	eps =0.1
	for i in range(10):
		for j in range(2,5):
			assert(abs(2**(1/j)-sqrt(2,j,eps))<eps)
		eps /= 10

def fibo_v2(n,lista_nr_pasi):
	r,nr_pasi = putere_mat([[0,1],[1,1]],n+1)
	lista_nr_pasi.append((n,nr_pasi))
	return r[0][0]

def ruleaza_teste():
	teste_fibonacci(fibo_v0,"fibo_v0_nr_pasi.csv")
	teste_fibonacci(fibo_v1,"fibo_v1_nr_pasi.csv")
	teste_fibonacci(fibo_v2,"fibo_v2_nr_pasi.csv")
	teste_radical()

ruleaza_teste()
