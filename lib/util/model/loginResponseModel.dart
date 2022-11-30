class loginResponseModel {
  bool _status;

  loginResponseModel(this._status);

  get status => _status;

  set status(value) {
    _status = value;
  }
}

class tokenResponseModel {
  bool _tokenstatus;
  var _data;

  tokenResponseModel(this._tokenstatus, this._data);

  bool get tokenstatus => _tokenstatus;

  set tokenstatus(bool value) {
    _tokenstatus = value;
  }

  get data => _data;

  set data(value) {
    _data = value;
  }
}
