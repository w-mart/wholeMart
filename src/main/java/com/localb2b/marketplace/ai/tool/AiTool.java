package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;

public interface AiTool {

    String name();

    boolean supports(Intent intent);

    AiToolResponse execute(AiToolRequest request);
}

