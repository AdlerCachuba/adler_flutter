import 'package:flutter/cupertino.dart';
import 'package:flutter_adler/app/database/databaseConnect.dart';
import 'package:flutter_adler/app/domain/model/newObra.dart';
import 'package:flutter_adler/app/domain/services/obra_service.dart';
import 'package:mobx/mobx.dart';

part 'obra_form_back.g.dart';

class ObraFormBack = _ObraFormBack with _$ObraFormBack;

abstract class _ObraFormBack with Store{

  var _servico = DatabaseConnect.instance;
  var _validacao = ObraService();
  bool _nomeIsValid;
  bool _qtddIsValid;

  NewObra obra;

  @action
  bool get isValid => _nomeIsValid && _qtddIsValid;

  _ObraFormBack(BuildContext context){
    var parametro = ModalRoute.of(context).settings.arguments;
    obra = (parametro == null) ? NewObra() : parametro;
  }

  save() async{
    await _servico.inserirDadosTabelaObra(obra);
  }

  String validaNomeObra(String nomeObra){
    try{
      _validacao.validarNome(nomeObra);
      _nomeIsValid = true;
    }catch(e){
      _nomeIsValid = false;
      return e.toString();
    }
  }

  String validaQtdd(var qtdd){
    try{
      _validacao.validarQuantidade(int.parse(qtdd));
      _qtddIsValid = true;
    }catch(e){
      _qtddIsValid = false;
      return e.toString();
    }
  }

}