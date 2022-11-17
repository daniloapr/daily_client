.PHONY: pigeon
pigeon:
	flutter pub run pigeon \
	--input pigeons/daily_client_messenger.dart \
	--dart_out lib/pigeon.g.dart \
	--objc_header_out ios/Classes/pigeon.h \
	--objc_source_out ios/Classes/pigeon.m \
	--experimental_swift_out ios/Classes/Pigeon.swift \
	--java_out ./android/src/main/java/com/teamflowhq/daily_client/Pigeon.java \
	--java_package "com.teamflowhq.daily_client"
