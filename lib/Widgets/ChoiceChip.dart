// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class _ChoiceChip {

  Wrap chioice(){
    return Wrap(
        children: [
          ChoiceChip(
            label: Text("Bassa"),
            selected: true
            
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: Text("Media"),
            selected: true,
            
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: Text("Alta"),
            selected: true,
            
          ),
        ],
    );
  }
}

