///
//  Generated code. Do not modify.
//  source: aiapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PBCommonMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBCommonMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..m<$core.String, PBValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'params', entryClassName: 'PBCommonMessage.ParamsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: PBValue.create, packageName: const $pb.PackageName('proto.aiapp'))
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataBytes', $pb.PbFieldType.OY, protoName: 'dataBytes')
    ..hasRequiredFields = false
  ;

  PBCommonMessage._() : super();
  factory PBCommonMessage({
    $core.int? id,
    $core.Map<$core.String, PBValue>? params,
    $core.List<$core.int>? dataBytes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (params != null) {
      _result.params.addAll(params);
    }
    if (dataBytes != null) {
      _result.dataBytes = dataBytes;
    }
    return _result;
  }
  factory PBCommonMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBCommonMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBCommonMessage clone() => PBCommonMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBCommonMessage copyWith(void Function(PBCommonMessage) updates) => super.copyWith((message) => updates(message as PBCommonMessage)) as PBCommonMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBCommonMessage create() => PBCommonMessage._();
  PBCommonMessage createEmptyInstance() => create();
  static $pb.PbList<PBCommonMessage> createRepeated() => $pb.PbList<PBCommonMessage>();
  @$core.pragma('dart2js:noInline')
  static PBCommonMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBCommonMessage>(create);
  static PBCommonMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, PBValue> get params => $_getMap(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get dataBytes => $_getN(2);
  @$pb.TagNumber(3)
  set dataBytes($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDataBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearDataBytes() => clearField(3);
}

class PBValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intValue', $pb.PbFieldType.O3, protoName: 'intValue')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stringValue', protoName: 'stringValue')
    ..hasRequiredFields = false
  ;

  PBValue._() : super();
  factory PBValue({
    $core.int? intValue,
    $core.String? stringValue,
  }) {
    final _result = create();
    if (intValue != null) {
      _result.intValue = intValue;
    }
    if (stringValue != null) {
      _result.stringValue = stringValue;
    }
    return _result;
  }
  factory PBValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBValue clone() => PBValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBValue copyWith(void Function(PBValue) updates) => super.copyWith((message) => updates(message as PBValue)) as PBValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBValue create() => PBValue._();
  PBValue createEmptyInstance() => create();
  static $pb.PbList<PBValue> createRepeated() => $pb.PbList<PBValue>();
  @$core.pragma('dart2js:noInline')
  static PBValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBValue>(create);
  static PBValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get intValue => $_getIZ(0);
  @$pb.TagNumber(1)
  set intValue($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIntValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get stringValue => $_getSZ(1);
  @$pb.TagNumber(2)
  set stringValue($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStringValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearStringValue() => clearField(2);
}

class PBLoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBLoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PBUser>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: PBUser.create)
    ..hasRequiredFields = false
  ;

  PBLoginResponse._() : super();
  factory PBLoginResponse({
    $core.int? result,
    $core.String? message,
    PBUser? user,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (message != null) {
      _result.message = message;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory PBLoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBLoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBLoginResponse clone() => PBLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBLoginResponse copyWith(void Function(PBLoginResponse) updates) => super.copyWith((message) => updates(message as PBLoginResponse)) as PBLoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBLoginResponse create() => PBLoginResponse._();
  PBLoginResponse createEmptyInstance() => create();
  static $pb.PbList<PBLoginResponse> createRepeated() => $pb.PbList<PBLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static PBLoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBLoginResponse>(create);
  static PBLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get result => $_getIZ(0);
  @$pb.TagNumber(1)
  set result($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PBUser get user => $_getN(2);
  @$pb.TagNumber(3)
  set user(PBUser v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  PBUser ensureUser() => $_ensure(2);
}

class PBUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dbId', $pb.PbFieldType.O3, protoName: 'dbId')
    ..hasRequiredFields = false
  ;

  PBUser._() : super();
  factory PBUser({
    $core.int? dbId,
  }) {
    final _result = create();
    if (dbId != null) {
      _result.dbId = dbId;
    }
    return _result;
  }
  factory PBUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBUser clone() => PBUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBUser copyWith(void Function(PBUser) updates) => super.copyWith((message) => updates(message as PBUser)) as PBUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBUser create() => PBUser._();
  PBUser createEmptyInstance() => create();
  static $pb.PbList<PBUser> createRepeated() => $pb.PbList<PBUser>();
  @$core.pragma('dart2js:noInline')
  static PBUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBUser>(create);
  static PBUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get dbId => $_getIZ(0);
  @$pb.TagNumber(1)
  set dbId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDbId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbId() => clearField(1);
}

class PBChat extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBChat', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topicId', $pb.PbFieldType.O3, protoName: 'topicId')
    ..aOM<PBUser>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sender', subBuilder: PBUser.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PBChat._() : super();
  factory PBChat({
    $core.int? topicId,
    PBUser? sender,
    $core.String? message,
  }) {
    final _result = create();
    if (topicId != null) {
      _result.topicId = topicId;
    }
    if (sender != null) {
      _result.sender = sender;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PBChat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBChat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBChat clone() => PBChat()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBChat copyWith(void Function(PBChat) updates) => super.copyWith((message) => updates(message as PBChat)) as PBChat; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBChat create() => PBChat._();
  PBChat createEmptyInstance() => create();
  static $pb.PbList<PBChat> createRepeated() => $pb.PbList<PBChat>();
  @$core.pragma('dart2js:noInline')
  static PBChat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBChat>(create);
  static PBChat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get topicId => $_getIZ(0);
  @$pb.TagNumber(1)
  set topicId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTopicId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopicId() => clearField(1);

  @$pb.TagNumber(2)
  PBUser get sender => $_getN(1);
  @$pb.TagNumber(2)
  set sender(PBUser v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => clearField(2);
  @$pb.TagNumber(2)
  PBUser ensureSender() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class PBChatList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBChatList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..pc<PBChat>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chats', $pb.PbFieldType.PM, subBuilder: PBChat.create)
    ..hasRequiredFields = false
  ;

  PBChatList._() : super();
  factory PBChatList({
    $core.Iterable<PBChat>? chats,
  }) {
    final _result = create();
    if (chats != null) {
      _result.chats.addAll(chats);
    }
    return _result;
  }
  factory PBChatList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBChatList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBChatList clone() => PBChatList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBChatList copyWith(void Function(PBChatList) updates) => super.copyWith((message) => updates(message as PBChatList)) as PBChatList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBChatList create() => PBChatList._();
  PBChatList createEmptyInstance() => create();
  static $pb.PbList<PBChatList> createRepeated() => $pb.PbList<PBChatList>();
  @$core.pragma('dart2js:noInline')
  static PBChatList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBChatList>(create);
  static PBChatList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PBChat> get chats => $_getList(0);
}

class PBConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..pc<PBSuggest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestList', $pb.PbFieldType.PM, protoName: 'suggestList', subBuilder: PBSuggest.create)
    ..hasRequiredFields = false
  ;

  PBConfig._() : super();
  factory PBConfig({
    $core.Iterable<PBSuggest>? suggestList,
  }) {
    final _result = create();
    if (suggestList != null) {
      _result.suggestList.addAll(suggestList);
    }
    return _result;
  }
  factory PBConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBConfig clone() => PBConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBConfig copyWith(void Function(PBConfig) updates) => super.copyWith((message) => updates(message as PBConfig)) as PBConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBConfig create() => PBConfig._();
  PBConfig createEmptyInstance() => create();
  static $pb.PbList<PBConfig> createRepeated() => $pb.PbList<PBConfig>();
  @$core.pragma('dart2js:noInline')
  static PBConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBConfig>(create);
  static PBConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PBSuggest> get suggestList => $_getList(0);
}

class PBSuggest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBSuggest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..pc<PBSuggestItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestItem', $pb.PbFieldType.PM, protoName: 'suggestItem', subBuilder: PBSuggestItem.create)
    ..hasRequiredFields = false
  ;

  PBSuggest._() : super();
  factory PBSuggest({
    $core.String? title,
    $core.Iterable<PBSuggestItem>? suggestItem,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (suggestItem != null) {
      _result.suggestItem.addAll(suggestItem);
    }
    return _result;
  }
  factory PBSuggest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBSuggest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBSuggest clone() => PBSuggest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBSuggest copyWith(void Function(PBSuggest) updates) => super.copyWith((message) => updates(message as PBSuggest)) as PBSuggest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBSuggest create() => PBSuggest._();
  PBSuggest createEmptyInstance() => create();
  static $pb.PbList<PBSuggest> createRepeated() => $pb.PbList<PBSuggest>();
  @$core.pragma('dart2js:noInline')
  static PBSuggest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBSuggest>(create);
  static PBSuggest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<PBSuggestItem> get suggestItem => $_getList(1);
}

class PBSuggestItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBSuggestItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'proto.aiapp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'presetContent', protoName: 'presetContent')
    ..hasRequiredFields = false
  ;

  PBSuggestItem._() : super();
  factory PBSuggestItem({
    $core.String? title,
    $core.String? presetContent,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (presetContent != null) {
      _result.presetContent = presetContent;
    }
    return _result;
  }
  factory PBSuggestItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBSuggestItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBSuggestItem clone() => PBSuggestItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBSuggestItem copyWith(void Function(PBSuggestItem) updates) => super.copyWith((message) => updates(message as PBSuggestItem)) as PBSuggestItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBSuggestItem create() => PBSuggestItem._();
  PBSuggestItem createEmptyInstance() => create();
  static $pb.PbList<PBSuggestItem> createRepeated() => $pb.PbList<PBSuggestItem>();
  @$core.pragma('dart2js:noInline')
  static PBSuggestItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBSuggestItem>(create);
  static PBSuggestItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get presetContent => $_getSZ(1);
  @$pb.TagNumber(2)
  set presetContent($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPresetContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearPresetContent() => clearField(2);
}

