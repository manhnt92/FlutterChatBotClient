///
//  Generated code. Do not modify.
//  source: aiapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use pBCommonMessageDescriptor instead')
const PBCommonMessage$json = const {
  '1': 'PBCommonMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'params', '3': 2, '4': 3, '5': 11, '6': '.proto.aiapp.PBCommonMessage.ParamsEntry', '10': 'params'},
    const {'1': 'dataBytes', '3': 3, '4': 1, '5': 12, '10': 'dataBytes'},
  ],
  '3': const [PBCommonMessage_ParamsEntry$json],
};

@$core.Deprecated('Use pBCommonMessageDescriptor instead')
const PBCommonMessage_ParamsEntry$json = const {
  '1': 'ParamsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.proto.aiapp.PBValue', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `PBCommonMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBCommonMessageDescriptor = $convert.base64Decode('Cg9QQkNvbW1vbk1lc3NhZ2USDgoCaWQYASABKAVSAmlkEkAKBnBhcmFtcxgCIAMoCzIoLnByb3RvLmFpYXBwLlBCQ29tbW9uTWVzc2FnZS5QYXJhbXNFbnRyeVIGcGFyYW1zEhwKCWRhdGFCeXRlcxgDIAEoDFIJZGF0YUJ5dGVzGk8KC1BhcmFtc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EioKBXZhbHVlGAIgASgLMhQucHJvdG8uYWlhcHAuUEJWYWx1ZVIFdmFsdWU6AjgB');
@$core.Deprecated('Use pBValueDescriptor instead')
const PBValue$json = const {
  '1': 'PBValue',
  '2': const [
    const {'1': 'intValue', '3': 1, '4': 1, '5': 5, '10': 'intValue'},
    const {'1': 'stringValue', '3': 2, '4': 1, '5': 9, '10': 'stringValue'},
  ],
};

/// Descriptor for `PBValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBValueDescriptor = $convert.base64Decode('CgdQQlZhbHVlEhoKCGludFZhbHVlGAEgASgFUghpbnRWYWx1ZRIgCgtzdHJpbmdWYWx1ZRgCIAEoCVILc3RyaW5nVmFsdWU=');
@$core.Deprecated('Use pBLoginResponseDescriptor instead')
const PBLoginResponse$json = const {
  '1': 'PBLoginResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 5, '10': 'result'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.proto.aiapp.PBUser', '10': 'user'},
  ],
};

/// Descriptor for `PBLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBLoginResponseDescriptor = $convert.base64Decode('Cg9QQkxvZ2luUmVzcG9uc2USFgoGcmVzdWx0GAEgASgFUgZyZXN1bHQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRInCgR1c2VyGAMgASgLMhMucHJvdG8uYWlhcHAuUEJVc2VyUgR1c2Vy');
@$core.Deprecated('Use pBUserDescriptor instead')
const PBUser$json = const {
  '1': 'PBUser',
  '2': const [
    const {'1': 'dbId', '3': 1, '4': 1, '5': 5, '10': 'dbId'},
    const {'1': 'freeMsgLeft', '3': 2, '4': 1, '5': 5, '10': 'freeMsgLeft'},
    const {'1': 'isPurchased', '3': 3, '4': 1, '5': 8, '10': 'isPurchased'},
  ],
};

/// Descriptor for `PBUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBUserDescriptor = $convert.base64Decode('CgZQQlVzZXISEgoEZGJJZBgBIAEoBVIEZGJJZBIgCgtmcmVlTXNnTGVmdBgCIAEoBVILZnJlZU1zZ0xlZnQSIAoLaXNQdXJjaGFzZWQYAyABKAhSC2lzUHVyY2hhc2Vk');
@$core.Deprecated('Use pBChatDescriptor instead')
const PBChat$json = const {
  '1': 'PBChat',
  '2': const [
    const {'1': 'topicId', '3': 1, '4': 1, '5': 5, '10': 'topicId'},
    const {'1': 'sender', '3': 2, '4': 1, '5': 11, '6': '.proto.aiapp.PBUser', '10': 'sender'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PBChat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBChatDescriptor = $convert.base64Decode('CgZQQkNoYXQSGAoHdG9waWNJZBgBIAEoBVIHdG9waWNJZBIrCgZzZW5kZXIYAiABKAsyEy5wcm90by5haWFwcC5QQlVzZXJSBnNlbmRlchIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use pBChatListDescriptor instead')
const PBChatList$json = const {
  '1': 'PBChatList',
  '2': const [
    const {'1': 'chats', '3': 1, '4': 3, '5': 11, '6': '.proto.aiapp.PBChat', '10': 'chats'},
  ],
};

/// Descriptor for `PBChatList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBChatListDescriptor = $convert.base64Decode('CgpQQkNoYXRMaXN0EikKBWNoYXRzGAEgAygLMhMucHJvdG8uYWlhcHAuUEJDaGF0UgVjaGF0cw==');
@$core.Deprecated('Use pBConfigDescriptor instead')
const PBConfig$json = const {
  '1': 'PBConfig',
  '2': const [
    const {'1': 'suggestList', '3': 1, '4': 3, '5': 11, '6': '.proto.aiapp.PBSuggest', '10': 'suggestList'},
    const {'1': 'suggestPurchaseMsg', '3': 2, '4': 1, '5': 9, '10': 'suggestPurchaseMsg'},
  ],
};

/// Descriptor for `PBConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBConfigDescriptor = $convert.base64Decode('CghQQkNvbmZpZxI4CgtzdWdnZXN0TGlzdBgBIAMoCzIWLnByb3RvLmFpYXBwLlBCU3VnZ2VzdFILc3VnZ2VzdExpc3QSLgoSc3VnZ2VzdFB1cmNoYXNlTXNnGAIgASgJUhJzdWdnZXN0UHVyY2hhc2VNc2c=');
@$core.Deprecated('Use pBSuggestDescriptor instead')
const PBSuggest$json = const {
  '1': 'PBSuggest',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'suggestItem', '3': 2, '4': 3, '5': 11, '6': '.proto.aiapp.PBSuggestItem', '10': 'suggestItem'},
  ],
};

/// Descriptor for `PBSuggest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBSuggestDescriptor = $convert.base64Decode('CglQQlN1Z2dlc3QSFAoFdGl0bGUYASABKAlSBXRpdGxlEjwKC3N1Z2dlc3RJdGVtGAIgAygLMhoucHJvdG8uYWlhcHAuUEJTdWdnZXN0SXRlbVILc3VnZ2VzdEl0ZW0=');
@$core.Deprecated('Use pBSuggestItemDescriptor instead')
const PBSuggestItem$json = const {
  '1': 'PBSuggestItem',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'presetContent', '3': 2, '4': 1, '5': 9, '10': 'presetContent'},
  ],
};

/// Descriptor for `PBSuggestItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBSuggestItemDescriptor = $convert.base64Decode('Cg1QQlN1Z2dlc3RJdGVtEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIkCg1wcmVzZXRDb250ZW50GAIgASgJUg1wcmVzZXRDb250ZW50');
@$core.Deprecated('Use pBDailyLimitDescriptor instead')
const PBDailyLimit$json = const {
  '1': 'PBDailyLimit',
  '2': const [
    const {'1': 'isLimited', '3': 1, '4': 1, '5': 8, '10': 'isLimited'},
  ],
};

/// Descriptor for `PBDailyLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBDailyLimitDescriptor = $convert.base64Decode('CgxQQkRhaWx5TGltaXQSHAoJaXNMaW1pdGVkGAEgASgIUglpc0xpbWl0ZWQ=');
