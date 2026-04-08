package com.citadel.backend.vo.Migration;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MigrationLogRespVo {

    List<Tab> tabAndContentList;

    @Getter
    @Setter
    public static class Tab {
        private String tabName;
        private String message = "Success";
        private List<TabContent> tabContentList = new ArrayList<>();

        @Getter
        @Setter
        public static class TabContent {
            private Integer rowNumber;
            private String rowError;
        }
    }
}
