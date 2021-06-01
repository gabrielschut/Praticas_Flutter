import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_exemplo/providers/product.dart';
import 'package:provider/provider.dart';

class ProductFormScrenn extends StatefulWidget {
  @override
  _ProductFormScrennState createState() => _ProductFormScrennState();
}

class _ProductFormScrennState extends State<ProductFormScrenn> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_formData.isEmpty){
      final product = ModalRoute.of(context).settings.arguments as Product;

      if(product != null){
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'];
      }else{
        _formData['price'] = 0.0;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _updateImage() {
    if (validImage(_imageUrlController.text)) {
      setState(() {});
    }
  }

  void _saveForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    final product = Product(
      id:  _formData['id'],
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );
    final products = Provider.of<Products>(context, listen: false);
    if(_formData['id'] == null){
      products.addProduct(product);
    }else{
      products.updateProduct(product);
    }
    Navigator.of(context).pop();
  }

  bool validImage(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool starWithHttps = url.toLowerCase().startsWith('https://');
    bool endWithPng = url.toLowerCase().endsWith('.png');
    bool endWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (starWithHttps || startWithHttp) &&
        (endWithPng || endWithJpg || endWithJpeg);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Produto'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.lightGreenAccent,
            ),
            onPressed: () {
              _saveForm();
            },

          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              initialValue: _formData['title'],
              decoration: InputDecoration(labelText: 'Título'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value) => _formData['title'] = value,
              validator: (value) {
                bool vazio = value.trim().isEmpty;
                bool isValid = value.trim().length <= 3;
                if (vazio || isValid) {
                  return 'Erro! '
                      ' Nenhum texto encontrado';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _formData['price'].toString(),
              decoration: InputDecoration(labelText: 'Preço'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value) => _formData['price'] = double.tryParse(value),
              validator: (value){
                bool vazia = value.trim().isEmpty;
                double newPrice = double.tryParse(value);
                bool isValid = newPrice <= 0 || newPrice == null;
                if(isValid) {
                  return 'Insira um valor valido';
                }
                if(vazia){
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _formData['description'],
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onSaved: (value) => _formData['description'] = value,
              validator: (value){
                bool vazia = value.trim().isEmpty;
                bool minSize = value.length <= 5;
                if(vazia){
                  return 'Campo obrigatótio';
                }else if(minSize){
                  return 'A descrição deve conter pelo menos 5 caracters';
                }
                return null;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => _formData['imageUrl'] = value,
                      validator: (value) {
                        bool vazia = value.trim().isEmpty;
                        bool valida = validImage(value);
                        if (vazia) {
                          return 'Campo vazio!';
                        } else if (!valida) {
                          return 'Informe uma Url valida';
                        }
                        return null;
                      }),
                ),
                Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 8,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informa a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
