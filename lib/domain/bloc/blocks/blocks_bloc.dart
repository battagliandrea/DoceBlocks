import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

part 'blocks_event.dart';
part 'blocks_state.dart';

class BlocksBloc extends Bloc<BlocksEvent, BlocksState> {
  BlocksBloc() : super(GetBlocksInitial());

  @override
  Stream<BlocksState> mapEventToState(BlocksEvent event) async* {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET PAGES EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (event is GetBlocksEvent) {
      final blockRepository = Injector.provideBlockRepository();
      blockRepository.getBlocks(event.pageId);
    } else if (event is AddBlocksEvent) {
      final blockRepository = Injector.provideBlockRepository();
      final sectionRepository = Injector.provideSectionRepository();
      final selectedSectionId = sectionRepository.getSelectedSectionId();
      final blocks = event.blocks.map((block) {
        block.pages.add(selectedSectionId);
        return block;
      }).toList();

      blockRepository.addBlocks(blocks);
    } else {
      yield GetBlocksInitial();
    }
  }
}
