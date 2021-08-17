from django.http import HttpResponse
from django.shortcuts import render

def hello(request):
    return HttpResponse("hello world!")

def index(request):
    pass

def bio(request):
    pass

def runoob(request):
    context = {}
    context['hello'] = 'Hello World'
    return render(request,'runoob.html',context)